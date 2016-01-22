//
//  PodcastCell.m
//  downcast
//
//  Created by Justin Kovalchuk on 1/21/16.
//  Copyright © 2016 StudyStream. All rights reserved.
//

#import "PodcastCell.h"
#import "PodcastModel.h"
#import <UIImageView+AFNetworking.h>

@implementation PodcastCell

-(void)configureCellWithPodcast:(PodcastModel *)p {
    UIImage *loading = [UIImage imageNamed:@"loading"];
    
    self.podcastTitle.text = p.title;
    if (p.imageUrl) {
        [self.thumbnail setImageWithURL:p.imageUrl placeholderImage:loading];
    }
    else {
        self.thumbnail.image = loading;
    }
}

@end
