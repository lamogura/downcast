//
//  Podcast.m
//  downcast
//
//  Created by Justin Kovalchuk on 1/21/16.
//  Copyright © 2016 StudyStream. All rights reserved.
//

#import "Podcast.h"
#import <AFNetworking/AFNetworking.h>

@implementation Podcast

- (instancetype)initWithName:(NSString *)name url:(NSURL *)url
{
    self = [super init];
    if (self) {
        self.name = name;
        self.url = url;
    }
    return self;
}

- (void)fetchFeedInfo {
    if (self.url) {
        NSLog(@"Fetching feed for podcast: %@ (%@)", self.name, self.url);
        MWFeedParser *parser = [[MWFeedParser alloc] initWithFeedURL:self.url];
        parser.delegate = self;
        parser.connectionType = ConnectionTypeSynchronously;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [parser parse];
        });
    }
}

#pragma mark - MWFeedParser Delegate

- (void)feedParserDidStart:(MWFeedParser *)parser { // Called when data has downloaded and parsing has begun
    
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info { // Provides info about the feed
    dispatch_async(dispatch_get_main_queue(), ^{
        self.podcastInfo = info;
        if ([self.delegate respondsToSelector:@selector(podcast:didGetFeedInfo:)]) {
            [self.delegate podcast:self didGetFeedInfo:info];
        }
    });
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item { // Provides info about a feed item
    
}

- (void)feedParserDidFinish:(MWFeedParser *)parser { // Parsing complete or stopped at any time by `stopParsing`
    
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error { // Parsing failed
    
}

@end
