//
//  ViewController.m
//  downcast
//
//  Created by Justin Kovalchuk on 1/21/16.
//  Copyright © 2016 StudyStream. All rights reserved.
//

#import "PodcastListVC.h"
#import "PodcastCell.h"

@interface PodcastListVC ()
@property (nonatomic, strong) NSArray *podcasts;
@end

@implementation PodcastListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.tableFooterView = [UIView new]; // remove lines
    
    self.podcasts = [NSArray array];
}

- (IBAction)refreshList:(id)sender {
    NSURL *podcastsURL = [[NSBundle mainBundle] URLForResource:@"podcasts" withExtension:@"opml"];
    
    NSArray *casts = [Podcast podcastsFromOPMLFile:podcastsURL];
    if (casts) {
        for (Podcast *p in casts) {
            p.delegate = self;
            [p refreshFeed];
        }
        
        self.podcasts = casts;
        [self.tableView reloadData];
    }
}

#pragma mark - PodcastFeedDelegate
-(void)podcastDidGetFeedInfo:(Podcast *)podcast {
    NSInteger idx = [self.podcasts indexOfObject:podcast];
    NSIndexPath cellPath = [NSIndexPath indexPathForRow:idx inSection:0]

    // reconfigure if we just got info w/ logo url
    PodcastCell *cell = [self.tableView cellForRowAtIndexPath:cellPath];
    if (cell) {
        [cell configureCellWithPodcast:podcast];
    }
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
