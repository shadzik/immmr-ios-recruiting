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
    @weakify(self)
    [self.apiClient getCastForMovie:self.movie.movieid successBlock:^(NSDictionary *result) {
        @strongify(self)
        NSArray *castArray = result[@"cast"];
        NSArray *crewArray = result[@"crew"];
        
        self.cast = [castArray ma_map:^id(id obj) {
            IMRCast *cast = [[IMRCast alloc] initWithDictionary:obj];
            return cast;
        }];
        
        self.crew = [crewArray ma_map:^id(id obj) {
            IMRCrew *crew = [[IMRCrew alloc] initWithDictionary:obj];
            return crew;
        }];
        
        NSPredicate *directorPredicate = [NSPredicate predicateWithBlock:^BOOL(IMRCrew *crewMember, NSDictionary<NSString *,id> * _Nullable bindings) {
            return [[crewMember.job lowercaseString] isEqualToString:@"director"] ? YES : NO;
        }];
        self.directors = [self.crew filteredArrayUsingPredicate:directorPredicate];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [(RACSubject *)self.reloadDataSignal sendNext:nil];
        });
    }];
}

- (NSInteger)numberOfSections
{
    return IMRMovieDetailsSections_count;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section
{
    if (section == IMRMovieDetailsSection_director) {
        return self.directors.count;
    } else if (section == IMRMovieDetailsSection_cast) {
        if (self.cast.count > shortCastNumber+1) {
            // + 1 for "show more" cell
            return self.shouldShowFullCast ? self.cast.count : shortCastNumber+1;
        }
        return self.cast.count;
    } else if (section == IMRMovieDetailsSection_overview) {
        return 1;
    }
    
    return 0;
}

@end
