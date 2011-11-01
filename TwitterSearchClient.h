//
//  TwitterSearchClient.h
//  Find Tweets
//
//  Created by Michael Koby on 10/24/11.
//  Copyright (c) 2011 Teabrick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "TweetItem.h"

extern NSString * const kTwitterSearchBaseURL;

@interface TwitterSearchClient : NSObject {
}

+ (NSArray *)searchTwitterWithQuery:(NSString *)query;

+ (NSString *)getJSONStringFromURL:(NSURL *)url;
+ (NSDictionary *)getJSONDictionaryFromJSONString:(NSString *)jsonString;
+ (NSArray *)getTweetItemsFromJSONDictionary:(NSDictionary *)jsonDictionary;

@end
