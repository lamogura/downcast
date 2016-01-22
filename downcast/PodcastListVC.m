//
//  ViewController.m
//  downcast
//
//  Created by Justin Kovalchuk on 1/21/16.
//  Copyright © 2016 StudyStream. All rights reserved.
//

#import "PodcastListVC.h"
#import "PodcastCell.h"
#import "APIManager.h"
#import "EpisodeListVC.h"

#import <SVProgressHUD/SVProgressHUD.h>

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
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[APIManager sharedManger] getPodcastsWithSuccess:^(NSArray *podcasts) {
        self.podcasts = podcasts;
        [self.tableView reloadData];
        [SVProgressHUD showSuccessWithStatus:@"Done!"];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
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
    PodcastModel *podcast = self.podcasts[indexPath.row];
    
    [cell configureCellWithPodcast:podcast];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PodcastModel *podcast = self.podcasts[indexPath.row];
    
    [SVProgressHUD showWithStatus:@"Loading..."];
    
    EpisodeListVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"EpisodeListVC"];
    vc.podcast = podcast;
    [vc loadEpisodes];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
