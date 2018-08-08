//
//  IMRMovieAPIClient.h
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface IMRMovieAPIClient : AFHTTPSessionManager

+ (instancetype) sharedAPIClient;

- (void)getNowPlayingMovies:(void (^)(NSDictionary *result))success;

- (void) getCastForMovie:(NSString*)movieID
            successBlock:(void (^)(NSDictionary *result))success;

@end
