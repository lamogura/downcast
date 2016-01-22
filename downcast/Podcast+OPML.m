//
//  NSArray+OPML.m
//  downcast
//
//  Created by Justin Kovalchuk on 1/21/16.
//  Copyright © 2016 StudyStream. All rights reserved.
//

#import "Podcast+OMPL.h"

@implementation Podcast (OPML)

+ (NSArray *)podcastsFromOPMLFile:(NSURL *)opmlURL {
    OPMLParser *parser = [[OPMLParser alloc] initWithOPMLFile:opmlURL];

    BOOL success = [parser parse];
    if (success) {
        parser.podcasts;
    }
    else {
        return nil;
    }
}

@end

@interface OPMLParser ()
@property (nonatomic, strong) NSXMLParser *xmlParser;
// local property of podcasts found while parsing
@property (nonatomic, strong) NSMutableArray *parsedPodcasts; 
@end

@implementation OPMLParser

- (instancetype)initWithOPMLFile:(NSURL *)opmlURL
{
    self = [super init];
    if (self) {
        if (opmlURL == nil) {
            NSLog(@"%s: No URL passed.", __PRETTY_FUNCTION__);
        }
        else {        
            NSError *error = nil;
            NSData *data = [NSData dataWithContentsOfURL:opmlURL options:NSDataReadingMappedIfSafe error:&error];
            if (error) {
                NSLog(@"%s: Unable to load file data: %@", __PRETTY_FUNCTION__, [error localizedDescription]);
            }
            else {
                self.xmlParser = [[NSXMLParser alloc] initWithData:data];
                self.xmlParser.delegate = self;
            }
        }
    }
    return self;
}

- (BOOL)parse {
    if (self.xmlParser == nil) {
        NSLog("No XML parser, data was never loaded.");
        return FALSE;
    }

    self.parsedPodcasts = [NSMutableArray array];
    _podcasts = nil;

    BOOL success = [self.xmlParser parse];
    if (success) {
        _podcasts = [NSArray arrayWithArray:self.parsedPodcasts];
        NSLog(@"Found %lu Podcasts.", (unsigned long)_podcasts.count);
        return TRUE;
    } 
    else {
        NSLog(@"Error parsing document!");
        return FALSE;
    }
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
                                       namespaceURI:(NSString *)namespaceURI
                                      qualifiedName:(NSString *)qName
                                         attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    // TODO: check if this is common OPML definition or only for casts export
    BOOL isPodcast = ([elementName isEqualToString:@"outline"] && [attributeDict[@"type"] isEqualToString:@"rss"]);
    if (isPodcast) {
        NSString *title = attributeDict[@"text"]; NSAssert(title != nil, @"Failed to parse podcast name with info: %@", attributeDict);
        NSString *urlString = attributeDict[@"xmlUrl"]; NSAssert(urlString != nil, @"Failed to parse podcast url with info: %@", attributeDict);
        NSURL *url = [NSURL URLWithString:urlString];
        Podcast *p = [[Podcast alloc] initWithTitle:title url:url];
        [self.parsedPodcasts addObject:p];
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"%s: Parse error: %@", __PRETTY_FUNCTION__, parseError);
}

@end
