//
//  APIManager.m
//  downcast
//
//  Created by Justin Kovalchuk on 1/23/16.
//  Copyright © 2016 StudyStream. All rights reserved.
//

#import "APIManager.h"
#import "PodcastModel.h"
#import "EpisodeModel.h"
#import <Mantle/Mantle.h>

@implementation APIManager

-(void)getPodcastsWithSuccess:(void (^)(NSArray *podcasts))success
                      failure:(void (^)(NSError *error))failure {
    [self GET:@"/api/admin/podcasts" parameters:nil
      success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
          NSError *error;
          NSArray *podcasts = [MTLJSONAdapter modelsOfClass:[PodcastModel class] fromJSONArray:responseObject error:&error];
          if (error) {
              NSLog(@"Error: %@", [error localizedDescription]);
              failure(error);
          }
          else {
              success(podcasts);
          }
      }
      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          NSLog(@"Error: %@", [error localizedDescription]);
          failure(error);
    }];
}

-(void)getEpisodesForPodcast:(PodcastModel *)podcast
                 withSuccess:(void (^)(NSArray *episodes))success
                     failure:(void (^)(NSError *error))failure {
    
    NSString *path = [NSString stringWithFormat:@"/api/admin/podcasts/%@/episodes", podcast.podcastId];
    
    [self GET:path parameters:nil
      success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
          NSError *error;
          NSArray *episodes = [MTLJSONAdapter modelsOfClass:[EpisodeModel class] fromJSONArray:responseObject error:&error];
          if (error) {
              NSLog(@"Error: %@", [error localizedDescription]);
              failure(error);
          }
          else {
              for (EpisodeModel *ep in episodes) {
                  ep.podcast = podcast;
              }
              success(episodes);
          }
      }
      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          NSLog(@"Error: %@", [error localizedDescription]);
          failure(error);
      }];
}


@end
