//
//  EpisodeCell.m
//  downcast
//
//  Created by Justin Kovalchuk on 1/23/16.
//  Copyright © 2016 StudyStream. All rights reserved.
//

#import "EpisodeCell.h"
#import "EpisodeModel.h"
#import "PodcastModel.h"
#import <UIImageView+AFNetworking.h>

@implementation EpisodeCell

-(void)configureCellWithEpisode:(EpisodeModel *)episode {
    UIImage *loading = [UIImage imageNamed:@"loading"];
    
    self.episodeTitle.text = episode.title;

    PodcastModel *pod = episode.podcast;
    if (pod && pod.imageUrl) {
        [self.thumbnail setImageWithURL:pod.imageUrl placeholderImage:loading];
    }
    else {
        self.thumbnail.image = loading;
    }
    
    self.durationLabel.text = [NSString stringWithFormat:@"%d sec", episode.totalTime];
}

@end
