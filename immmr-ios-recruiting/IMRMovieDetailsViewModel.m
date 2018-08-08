//
//  IMRMovieDetailsViewModel.m
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import "IMRMovieDetailsViewModel.h"
#import "IMRMovieAPIClient.h"
#import "IMRMovie.h"
#import "IMRCast.h"
#import "IMRCrew.h"

NSInteger const shortCastNumber = 4;

@interface IMRMovieDetailsViewModel ()

@property (nonatomic, strong) IMRMovieAPIClient *apiClient;
@property (nonatomic, strong) IMRMovie *movie;
@property NSArray *cast;
@property NSArray *crew;
@property NSArray *directors;

@end

@implementation IMRMovieDetailsViewModel

- (instancetype)initWithAPIClient:(IMRMovieAPIClient *)apiClient movie:(IMRMovie*)movie
{
    self = [super init];
    if (self) {
        _apiClient = apiClient;
        _movie = movie;
        _reloadDataSignal = [[RACSubject subject] setNameWithFormat:@"IMRMovieDetailsViewModel reloadDataSignal"];
        
        [self getCast];
    }
    
    return self;
}

- (void)getCast
{
}

- (NSInteger)numberOfSections
{
    return 0;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section
{
    if (section == IMRMovieDetailsSection_director) {
        return 0;
    } else if (section == IMRMovieDetailsSection_cast) {
        return 0;
    } else if (section == IMRMovieDetailsSection_overview) {
        return 0;
    }
    
    return 0;
}

@end
