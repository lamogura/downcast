//
//  PodcastCell.m
//  downcast
//
//  Created by Justin Kovalchuk on 1/21/16.
//  Copyright © 2016 StudyStream. All rights reserved.
//

#import "PodcastCell.h"
#import "Podcast.h"
#import <UIImageView+AFNetworking.h>

@implementation PodcastCell

-(void)configureCellWithPodcast:(Podcast *)podcast {
    UIImage *loading = [UIImage imageNamed:@"loading"];
    
    self.podcastTitle.text = podcast.name;
    if (podcast.podcastInfo && podcast.podcastInfo.logo) {
        [self.thumbnail setImageWithURL:podcast.podcastInfo.logo placeholderImage:loading];
    }
    else {
        self.thumbnail.image = loading;
    }
}

@end
