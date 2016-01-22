//
//  NSArray+OPML.h
//  downcast
//
//  Created by Justin Kovalchuk on 1/21/16.
//  Copyright © 2016 StudyStream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Podcast.h"

@interface Podcast (OPML)

+ (NSArray *)podcastsFromOPMLFile:(NSURL *)opmlURL;

@end


@interface OPMLParser : NSObject <NSXMLParserDelegate>

// set upon successful parse
@property (nonatomic, readonly) NSArray *podcasts;

- (instancetype)initWithOPMLFileData:(NSData *)fileData;

// parses the OMPL file, returning success
- (BOOL)parse;

@end