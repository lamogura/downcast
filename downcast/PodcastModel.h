//
//  PodcastModel.h
//  downcast
//
//  Created by Justin Kovalchuk on 1/23/16.
//  Copyright © 2016 StudyStream. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface PodcastModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSNumber *podcastId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSURL *imageUrl;
@property (nonatomic, copy) NSURL *websiteUrl;

@end
