//
//  EpisodeCell.h
//  downcast
//
//  Created by Justin Kovalchuk on 1/23/16.
//  Copyright © 2016 StudyStream. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EpisodeModel;
@class PodcastModel;

@interface EpisodeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *episodeTitle;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;

-(void)configureCellWithEpisode:(EpisodeModel *)episode;

@end
