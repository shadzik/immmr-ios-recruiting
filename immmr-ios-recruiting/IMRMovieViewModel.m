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
    @weakify(self)
    [self.apiClient getNowPlayingMovies:^(NSDictionary *result) {
        
        @strongify(self)
        NSArray *movieArray = result[@"results"];
        
        self.nowPlayingMovies = [movieArray ma_map:^id(id obj) {
            IMRMovie *movie = [[IMRMovie alloc] initWithDictionary:obj];
            return movie;
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [(RACSubject *)self.reloadDataSignal sendNext:nil];
        });
    }];
}

- (NSInteger)numberOfSections
{
    return 1;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section
{
    return self.nowPlayingMovies.count;
}

@end
