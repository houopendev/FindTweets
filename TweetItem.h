//
//  TweetItem.h
//  Find Tweets
//
//  Created by Michael Koby on 10/24/11.
//  Copyright (c) 2011 Teabrick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TweetItem : NSObject {
    NSString *username;
    NSString *tweet;
    NSString *imageURL;
}

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *tweet;
@property (nonatomic, strong) NSString *imageURL;

- (TweetItem *)initWithAttributes:(NSDictionary *)attributes;

@end
