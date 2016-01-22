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
- (void)podcastDidStartRefresh:(Podcast *)podcast;
- (void)podcastDidGetFeedInfo:(Podcast *)podcast;
- (void)podcast:(Podcast *)podcast didFailToRefreshWithError:(NSError *)error;
- (void)podcastDidFinishRefresh:(Podcast *)podcast;
@end

@interface Podcast : MTLModel <MWFeedParserDelegate>

@property (nonatomic, readonly) NSString *podcastTitle;
@property (nonatomic, readonly) NSURL *podcastURL;

// set by calling refreshFeed 
@property (nonatomic, readonly) MWFeedInfo *podcastInfo;
// episodes
// more meta data?

@property (nonatomic, weak) id <PodcastFeedDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title url:(NSURL *)url;
- (void)refreshFeed;

@end
