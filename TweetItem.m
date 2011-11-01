//
//  TweetItem.m
//  Find Tweets
//
//  Created by Michael Koby on 10/24/11.
//  Copyright (c) 2011 Teabrick. All rights reserved.
//

#import "TweetItem.h"

@implementation TweetItem

@synthesize username, tweet, imageURL;

- (TweetItem *)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    
    if (!self)
        return nil;
    
    self.username = [attributes valueForKeyPath:@"from_user"];
    self.imageURL = [attributes valueForKeyPath:@"profile_image_url"];
    self.tweet = [attributes valueForKeyPath:@"text"];
    
    return self;
}

@end
