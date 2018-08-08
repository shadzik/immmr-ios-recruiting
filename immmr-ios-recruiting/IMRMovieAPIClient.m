//
//  IMRMovieAPIClient.m
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import "IMRMovieAPIClient.h"

static NSString * const kMovieDBAPIKey = @"44ca365916735e0057dff60fabdf7a07";
static NSString * const kMovieDBBaseURL = @"https://api.themoviedb.org/3/";

@implementation IMRMovieAPIClient

+ (instancetype) sharedAPIClient
{
    static IMRMovieAPIClient *client;
    static dispatch_once_t	onceToken;
    
    dispatch_once(&onceToken, ^{
        client = [[[self class] alloc] init];
    });
    return client;
}

- (id)init
{
    self = [super initWithBaseURL:[NSURL URLWithString:kMovieDBBaseURL]];
    if (self)
    {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.operationQueue.maxConcurrentOperationCount = 2;
    }
    return self;
}

- (void) getMovieDBService:(NSString*)service
                    params:(NSDictionary*)inDictionary
                   success:(void (^)(NSDictionary *result))success
                   failure:(void (^)(NSError *result))failure
{
    NSMutableDictionary *params = inDictionary ? [inDictionary mutableCopy] : [@{} mutableCopy];
    params[@"api_key"] = kMovieDBAPIKey;
    
    
    [self GET:service
   parameters:params
     progress:nil
      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          if (success)
          {
              success(responseObject);
          }
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          if (failure)
          {
              failure(error);
          }
      }];    
}

- (void)getNowPlayingMovies:(void (^)(NSDictionary *result))success
{
    NSString *service = @"movie/now_playing";
    
    [self getMovieDBService:service
                     params:nil
                    success:success
                    failure:nil];
}

- (void) getCastForMovie:(NSString*)movieID
            successBlock:(void (^)(NSDictionary *result))success
{
    NSString *service = [NSString stringWithFormat:@"movie/%@/credits", movieID];
    
    [self getMovieDBService:service
                     params:nil
                    success:success
                    failure:nil];
}

@end
