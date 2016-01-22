//
//  EpisodeListVC.m
//  downcast
//
//  Created by Justin Kovalchuk on 1/23/16.
//  Copyright © 2016 StudyStream. All rights reserved.
//

#import "EpisodeListVC.h"
#import "PodcastModel.h"
#import "EpisodeModel.h"
#import "EpisodeCell.h"
#import "APIManager.h"
#import <SVProgressHUD/SVProgressHUD.h>

@import AVFoundation;

@interface EpisodeListVC ()
@property (nonatomic, strong) NSArray *episodes;
@property (nonatomic, strong) AVPlayer *player;
@end

@implementation EpisodeListVC

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.tableView.emptyDataSetSource = self;
//    self.tableView.emptyDataSetDelegate = self;
//    self.tableView.tableFooterView = [UIView new]; // remove lines
//
    self.title = self.podcast.title;
    self.episodes = [NSArray array];
}

- (void)loadEpisodes {
    [[APIManager sharedManger] getEpisodesForPodcast:self.podcast
                                         withSuccess:^(NSArray *episodes) {
                                             self.episodes = episodes;
                                             [self.tableView reloadData];
                                             [SVProgressHUD showSuccessWithStatus:@"Done!"];
                                         } failure:^(NSError *error) {
                                             [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
                                         }];
}

#pragma mark - UITableView Datasource/Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.episodes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EpisodeCell *cell = (EpisodeCell *)[tableView dequeueReusableCellWithIdentifier:@"EpisodeCell"];
    EpisodeModel *episode = self.episodes[indexPath.row];
    
    [cell configureCellWithEpisode:episode];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EpisodeModel *episode = self.episodes[indexPath.row];
    if (episode.audioUrl) {
        self.player = [[AVPlayer alloc] initWithURL:episode.audioUrl];
        [self.player play];
    }
    else {
        [SVProgressHUD showErrorWithStatus:@"No URL for episode!"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
