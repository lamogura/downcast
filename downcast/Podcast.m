//
//  Podcast.m
//  downcast
//
//  Created by Justin Kovalchuk on 1/21/16.
//  Copyright © 2016 StudyStream. All rights reserved.
//

#import "Podcast.h"

@implementation Podcast

- (instancetype)initWithTitle:(NSString *)title url:(NSURL *)url
{
    self = [super init];
    if (self) {
        _podcastTitle = name;
        _podcastURL = url;
    }
    return self;
}

- (void)refreshFeed {
    if (self.podcastURL) {
        NSLog(@"Fetching feed for podcast: %@ (%@)", self.podcastTitle, self.podcastURL);
        MWFeedParser *parser = [[MWFeedParser alloc] initWithFeedURL:self.podcastURL];
        parser.delegate = self;
        // TODO: fix MWFeedParser to work async internally, doesnt work without a dispatch
        parser.connectionType = ConnectionTypeSynchronously;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [parser parse];
        });
    }
}

#pragma mark - MWFeedParser Delegate

// Called when data has downloaded and parsing has begun
- (void)feedParserDidStart:(MWFeedParser *)parser { 
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(podcastDidStartRefresh:)]) {
            [self.delegate podcastDidStartRefresh:self];
        }
    });
}

// Provides info about the feed
- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info { 
    dispatch_async(dispatch_get_main_queue(), ^{
        _podcastInfo = info;
        if ([self.delegate respondsToSelector:@selector(podcastDidGetFeedInfo:)]) {
            [self.delegate podcastDidGetFeedInfo:self];
        }
    });
}

// Provides info about a feed item
- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
    // add items to episodes array
}

// Parsing complete or stopped at any time by `stopParsing`
- (void)feedParserDidFinish:(MWFeedParser *)parser { 
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(podcastDidFinishRefresh:)]) {
            [self.delegate podcastDidFinishRefresh:self];
        }
    });
}

// Parsing failed
- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(podcast:didFailToRefreshWithError:)]) {
            [self.delegate podcast:self didFailToRefreshWithError:error];
        }
    });
}

@end
