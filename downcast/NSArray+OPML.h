//
//  NSArray+OPML.h
//  downcast
//
//  Created by Justin Kovalchuk on 1/21/16.
//  Copyright © 2016 StudyStream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (OPML)

+ (NSArray *)ss_urlArrayFromOPMLURL:(NSURL *)opmlURL;

@end


@interface OPMLParser : NSObject <NSXMLParserDelegate>

- (instancetype)initWithOPMLFileData:(NSData *)fileData;

- (NSArray *)startParsing;

@end