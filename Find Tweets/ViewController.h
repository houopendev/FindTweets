//
//  ViewController.h
//  Find Tweets
//
//  Created by Michael Koby on 10/25/11.
//  Copyright (c) 2011 Teabrick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController 
    <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource> {
    
        UISearchBar *twitterSearchBar;
        UITableView *twitterSearchResultsTable;
        NSArray *searchResultsAsTweets;
}

@property (nonatomic, strong) IBOutlet UISearchBar *twitterSearchBar;
@property (nonatomic, strong) IBOutlet UITableView *twitterSearchResultsTable;
@property (nonatomic, strong) NSArray *searchResultsAsTweets;

@end
