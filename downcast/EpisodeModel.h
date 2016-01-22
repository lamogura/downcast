//
//  EpisodeModel.h
//  downcast
//
//  Created by Justin Kovalchuk on 1/23/16.
//  Copyright © 2016 StudyStream. All rights reserved.
//

#import <Mantle/Mantle.h>

@class PodcastModel;

@interface EpisodeModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSNumber *totalTime;
@property (nonatomic, copy) NSURL *audioUrl;
@property (nonatomic, copy) NSURL *showUrl;
@property (nonatomic, copy) NSDate *publishedAt;

@property (nonatomic, strong) PodcastModel *podcast;

@end
