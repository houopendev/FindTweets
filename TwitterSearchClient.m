//
//  TwitterSearchClient.m
//  Find Tweets
//
//  Created by Michael Koby on 10/24/11.
//  Copyright (c) 2011 Teabrick. All rights reserved.
//

#import "TwitterSearchClient.h"

NSString * const kTwitterSearchBaseURL = @"http://search.twitter.com/search.json?q=";

@implementation TwitterSearchClient

+ (NSArray *)searchTwitterWithQuery:(NSString *)query {
    NSString *fullURL = [[NSString alloc] initWithFormat:@"%@%@", kTwitterSearchBaseURL, query];
    NSURL *url = [NSURL URLWithString:[fullURL stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    //NSLog(@"%@", fullURL);
    __block NSString *jsonString = nil;
    __block NSDictionary *jsonDictionary = nil;
    __block NSArray *tweets = nil;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t process_group = dispatch_group_create();
    
    dispatch_sync(queue, ^{
        jsonString = [self getJSONStringFromURL:url];
        //NSLog(@"%@", jsonString);
        jsonDictionary = [self getJSONDictionaryFromJSONString:jsonString];
        tweets = [self getTweetItemsFromJSONDictionary:jsonDictionary];
        
    });
    
    dispatch_group_wait(process_group, DISPATCH_TIME_FOREVER);    
    dispatch_release(process_group); 
    
    return tweets;
}

+ (NSString *)getJSONStringFromURL:(NSURL *)url {
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];    
    [request startSynchronous];

    NSError *error = [request error];
    
    if (error) {
        NSLog(@"%@", error);
        return nil;
    }
    
    return [request responseString];
}

+ (NSDictionary *)getJSONDictionaryFromJSONString:(NSString *)jsonString {
    if (jsonString == nil)
        return nil;
    
    NSData *jsonData = [NSData dataWithBytes:[jsonString UTF8String] length:jsonString.length];
    NSError *jsonError = nil;
    id json = nil;
    
    if( jsonData ) {
        json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&jsonError];
    }
    
    if( jsonError )
        NSLog(@"Error: %@", jsonError);
    
    if (json == nil) {
        return nil;
    }
    
    return (NSDictionary *)json;
}

+ (NSArray *)getTweetItemsFromJSONDictionary:(NSDictionary *)jsonDictionary {
    if (jsonDictionary == nil)
        return nil;
    
    NSMutableArray *tweets = [[NSMutableArray alloc] init];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t process_group = dispatch_group_create();
    
    dispatch_group_async(process_group, queue, ^{
        [[jsonDictionary objectForKey:@"results"] enumerateObjectsUsingBlock:^(id result, NSUInteger idx, BOOL *stop) {
            TweetItem *tweet = [[TweetItem alloc] initWithAttributes:result];
            [tweets addObject:tweet];
        }];
    });
    
    dispatch_group_wait(process_group, DISPATCH_TIME_FOREVER);    
    dispatch_release(process_group);
    
    return tweets;
}

@end
