//
//  PodcastCell.h
//  downcast
//
//  Created by Justin Kovalchuk on 1/21/16.
//  Copyright © 2016 StudyStream. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PodcastModel;

@interface PodcastCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UILabel *podcastTitle;

-(void)configureCellWithPodcast:(PodcastModel *)podcast;

@end
