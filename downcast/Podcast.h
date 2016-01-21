//
//  Podcast.h
//  downcast
//
//  Created by Justin Kovalchuk on 1/21/16.
//  Copyright © 2016 StudyStream. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <MWFeedParser/MWFeedParser.h>

@class Podcast;

@protocol PodcastFeedDelegate <NSObject>
@optional
- (void)podcast:(Podcast *)podcast didGetFeedInfo:(MWFeedInfo *)info;
@end

@interface Podcast : MTLModel <MWFeedParserDelegate>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) MWFeedInfo *podcastInfo;

@property (nonatomic, unsafe_unretained) id <PodcastFeedDelegate> delegate;

- (instancetype)initWithName:(NSString *)name url:(NSURL *)url;
- (void)fetchFeedInfo;

@end
