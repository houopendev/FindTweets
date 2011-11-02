//
//  ViewController.m
//  Find Tweets
//
//  Created by Michael Koby on 10/25/11.
//  Copyright (c) 2011 Teabrick. All rights reserved.
//

#import "ViewController.h"
#import "TwitterSearchClient.h"
#import "TweetItem.h"

@implementation ViewController

@synthesize searchResultsAsTweets, twitterSearchBar, twitterSearchResultsTable;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.twitterSearchBar = nil;
    self.twitterSearchResultsTable = nil;
    self.searchResultsAsTweets = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - 
#pragma UISearchBar Delegate Methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *query = searchBar.text;
    [searchBar resignFirstResponder];
    
    if ([query length] > 0) {
        self.searchResultsAsTweets = [TwitterSearchClient searchTwitterWithQuery:query];
        
        if ([self.searchResultsAsTweets count] > 0) {
            [self.twitterSearchResultsTable reloadData];
            self.twitterSearchResultsTable.hidden = NO;
        }
    }
}

#pragma mark - 
#pragma mark TableView Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.searchResultsAsTweets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *TweetItemCellIdentifier = @"TweetItemCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TweetItemCellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TweetItemCell" owner:self options:nil];
        
        if ([nib count] > 0) {
            cell = [nib objectAtIndex:0];
        } else {
            NSLog(@"failed to load TweetItemCell from nib");
        }
    }
    
    NSUInteger row = [indexPath row];
    TweetItem *tweet = [self.searchResultsAsTweets objectAtIndex:row];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:2];
    nameLabel.text = tweet.username;
    
    UILabel *tweetLabel = (UILabel *)[cell viewWithTag:4];
    tweetLabel.text = tweet.tweet;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *avatarImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:tweet.imageURL]]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            UIImageView *avatarImageView = (UIImageView *)[cell viewWithTag:1];
            avatarImageView.image = avatarImage;
        });
    });
    
    return cell;
}

@end
