//
//  APIManager.h
//  downcast
//
//  Created by Justin Kovalchuk on 1/23/16.
//  Copyright © 2016 StudyStream. All rights reserved.
//

#import "SessionManager.h"

@class PodcastModel;

@interface APIManager : SessionManager

-(void)getPodcastsWithSuccess:(void (^)(NSArray *podcasts))success
                      failure:(void (^)(NSError *error))failure;

-(void)getEpisodesForPodcast:(PodcastModel *)podcast
                 withSuccess:(void (^)(NSArray *episodes))success
                      failure:(void (^)(NSError *error))failure;

@end
