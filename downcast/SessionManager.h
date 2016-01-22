//
//  DowncastClient.h
//  downcast
//
//  Created by Justin Kovalchuk on 1/23/16.
//  Copyright © 2016 StudyStream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPSessionManager.h>

@interface SessionManager : AFHTTPSessionManager

+ (id)sharedManger;
    
@end
