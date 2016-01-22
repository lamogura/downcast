//
//  EpisodeModel.m
//  downcast
//
//  Created by Justin Kovalchuk on 1/23/16.
//  Copyright © 2016 StudyStream. All rights reserved.
//

#import "EpisodeModel.h"


@implementation EpisodeModel

#pragma mark - Mantle JSONKeyPathsByPropertyKey

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.zzz'Z'";
    return dateFormatter;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"title" : @"title",
             @"subTitle" : @"subTitle",
             @"summary" : @"description",
             @"audioUrl" : @"audioUrl",
             @"showUrl" : @"showUrl",
             @"totalTime" : @"totalTime",
             @"publishedAt" : @"publishedAt"
             };
}

#pragma mark - JSON Transformers

+ (NSValueTransformer *)audioUrlJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *urlString, BOOL *success, NSError *__autoreleasing *error) {
        return [NSURL URLWithString:urlString];
    } reverseBlock:^id(NSURL *url, BOOL *success, NSError *__autoreleasing *error) {
        return url.absoluteString;
    }];
}

+ (NSValueTransformer *)showUrlJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *urlString, BOOL *success, NSError *__autoreleasing *error) {
        return [NSURL URLWithString:urlString];
    } reverseBlock:^id(NSURL *url, BOOL *success, NSError *__autoreleasing *error) {
        return url.absoluteString;
    }];
}

+ (NSValueTransformer *)publishedAtJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

@end
