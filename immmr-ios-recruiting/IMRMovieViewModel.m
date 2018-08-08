//
//  IMRMovieViewModel.m
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import "IMRMovieViewModel.h"
#import "IMRMovieAPIClient.h"
#import "IMRMovie.h"

@interface IMRMovieViewModel ()

@property (nonatomic, strong) IMRMovieAPIClient *apiClient;
@property NSArray *nowPlayingMovies;

@end

@implementation IMRMovieViewModel

- (instancetype)initWithAPIClient:(IMRMovieAPIClient *)apiClient
{
    self = [super init];
    if (self) {
        _apiClient = apiClient;
        _reloadDataSignal = [[RACSubject subject] setNameWithFormat:@"IMRMovieViewModel reloadDataSignal"];
        
        [self getNowPlayingMovies];
    }
    
    return self;
}

- (void)getNowPlayingMovies
{
}

@end
