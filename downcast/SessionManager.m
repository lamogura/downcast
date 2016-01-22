//
//  DowncastClient.m
//  downcast
//
//  Created by Justin Kovalchuk on 1/23/16.
//  Copyright © 2016 StudyStream. All rights reserved.
//

#import "SessionManager.h"

static NSString *const kBaseURL = @"https://dropcast.herokuapp.com";

@implementation SessionManager

- (id)init {
    self = [super initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    if(!self) return nil;
    
    self.responseSerializer = [AFJSONResponseSerializer serializer];

    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    [serializer setValue:@"sonic" forHTTPHeaderField:@"xadmin"];
    self.requestSerializer = serializer;
    
    return self;
}

+ (id)sharedManger {
    static SessionManager *_manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    
    return _manager;
}

@end
