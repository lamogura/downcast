//
//  ViewController.m
//  downcast
//
//  Created by Justin Kovalchuk on 1/21/16.
//  Copyright © 2016 StudyStream. All rights reserved.
//

#import "PodcastListVC.h"
#import "Podcast.h"
#import "PodcastCell.h"
#import "NSArray+OPML.h"

@interface PodcastListVC ()
@property (nonatomic, strong) NSArray *podcasts;
@end

@implementation PodcastListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.tableFooterView = [UIView new];
    
    self.podcasts = [NSArray array];
}

- (IBAction)refreshList:(id)sender {
    NSURL *podcastsURL = [[NSBundle mainBundle] URLForResource:@"podcasts" withExtension:@"opml"];
    
    NSArray *allPodcats = [NSArray ss_urlArrayFromOPMLURL:podcastsURL];
    for (Podcast *p in allPodcats) {
        p.delegate = self;
        [p fetchFeedInfo];
    }
    
    self.podcasts = allPodcats;
    [self.tableView reloadData];
}

#pragma mark - DZNEmptyData Datasource/Delegate
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"Hit refreash to load from OPML";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

#pragma mark - UITableView Datasource/Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.podcasts.count;
}

-(void)podcast:(Podcast *)podcast didGetFeedInfo:(MWFeedInfo *)info {
    NSInteger idx = [self.podcasts indexOfObject:podcast];
    PodcastCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
    if (cell) {
        [cell configureCellWithPodcast:podcast];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PodcastCell *cell = (PodcastCell *)[tableView dequeueReusableCellWithIdentifier:@"PodcastCell"];
    Podcast *podcast = self.podcasts[indexPath.row];
    
    [cell configureCellWithPodcast:podcast];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
