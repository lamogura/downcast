//
//  PodcastModel.m
//  downcast
//
//  Created by Justin Kovalchuk on 1/23/16.
//  Copyright © 2016 StudyStream. All rights reserved.
//

#import "PodcastModel.h"

@implementation PodcastModel

#pragma mark - Mantle JSONKeyPathsByPropertyKey

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"title": @"title",
             @"summary": @"description",
             @"imageUrl": @"imageUrl",
             @"websiteUrl": @"websiteUrl",
             @"podcastId": @"id"
             };
}

#pragma mark - JSON Transformers

+ (NSValueTransformer *)imageUrlJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *urlString, BOOL *success, NSError *__autoreleasing *error) {
        return [NSURL URLWithString:urlString];
    } reverseBlock:^id(NSURL *url, BOOL *success, NSError *__autoreleasing *error) {
        return url.absoluteString;
    }];
}

+ (NSValueTransformer *)websiteUrlJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *urlString, BOOL *success, NSError *__autoreleasing *error) {
        return [NSURL URLWithString:urlString];
    } reverseBlock:^id(NSURL *url, BOOL *success, NSError *__autoreleasing *error) {
        return url.absoluteString;
    }];
}
    
@end
