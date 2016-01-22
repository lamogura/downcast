//
//  EpisodeListVC.h
//  downcast
//
//  Created by Justin Kovalchuk on 1/23/16.
//  Copyright © 2016 StudyStream. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PodcastModel;

@interface EpisodeListVC : UITableViewController

@property (nonatomic, strong) PodcastModel *podcast;

- (void)loadEpisodes;

@end
