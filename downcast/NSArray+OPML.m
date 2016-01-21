//
//  NSArray+OPML.m
//  downcast
//
//  Created by Justin Kovalchuk on 1/21/16.
//  Copyright © 2016 StudyStream. All rights reserved.
//

#import "NSArray+OPML.h"
#import "Podcast.h"

@implementation NSArray (OPML)

+ (NSArray *)ss_urlArrayFromOPMLURL:(NSURL *)opmlURL {
    if (opmlURL == nil) {
        NSLog(@"%s: No URL for resource %@", __PRETTY_FUNCTION__, opmlURL);
        return nil;
    }
    
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfURL:opmlURL options:NSDataReadingMappedIfSafe error:&error];
    if (error != nil) {
        NSLog(@"%s: Unable to load file data: %@", __PRETTY_FUNCTION__, [error localizedDescription]);
        return nil;
    }
    
    OPMLParser *parser = [[OPMLParser alloc] initWithOPMLFileData:data];

    NSArray *podcasts = [parser startParsing];
    
    return podcasts;
}

@end

@interface OPMLParser ()
@property (nonatomic, strong) NSXMLParser *xmlParser;
@property (nonatomic, strong) NSMutableArray *podcasts;
@end

@implementation OPMLParser

- (instancetype)initWithOPMLFileData:(NSData *)fileData
{
    self = [super init];
    if (self) {
        self.xmlParser = [[NSXMLParser alloc] initWithData:fileData];
        self.xmlParser.delegate = self;
    }
    return self;
}

- (NSArray *)startParsing {
    self.podcasts = [NSMutableArray array];
    BOOL success = [self.xmlParser parse];
    if (success) {
        NSLog(@"Found %lu Podcasts.", (unsigned long)self.podcasts.count);
    } else {
        NSLog(@"Error parsing document!");
    }
    return self.podcasts;
}

-(void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
   attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {

    BOOL isPodcast = ([elementName isEqualToString:@"outline"] && [attributeDict[@"type"] isEqualToString:@"rss"]);
    if (isPodcast) {
        NSString *name = attributeDict[@"text"]; NSAssert(name != nil, @"Failed to parse podcast name with info: %@", attributeDict);
        NSString *urlString = attributeDict[@"xmlUrl"]; NSAssert(urlString != nil, @"Failed to parse podcast url with info: %@", attributeDict);
        NSURL *url = [NSURL URLWithString:urlString];
        Podcast *pod = [[Podcast alloc] initWithName:name url:url];
        [self.podcasts addObject:pod];
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"%@", parseError);
}

@end
