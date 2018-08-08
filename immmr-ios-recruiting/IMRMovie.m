//
//  IMRMovie.m
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import "IMRMovie.h"

static NSString* const kMovie_original_title   = @"original_title";
static NSString* const kMovie_overview         = @"overview";
static NSString* const kMovie_poster_path      = @"poster_path";
static NSString* const kMovie_release_date     = @"release_date";
static NSString* const kMovie_title            = @"title";
static NSString* const kMovie_movieid          = @"id";

@interface IMRMovie ()

@property NSString *movieid;
@property NSString *original_title;
@property NSString *overview;
@property NSString *poster_path;
@property NSString *release_date;
@property NSString *title;

@property NSDictionary *dictionary;

@end

@implementation IMRMovie

- (instancetype)initWithDictionary:(NSDictionary*)inDict
{
    self = [super init];
    if (self)
    {
        _movieid = inDict[kMovie_movieid];
        _original_title = inDict[kMovie_original_title];
        _overview = inDict[kMovie_overview];
        _poster_path = [self createFullPosterPathWithLastComponent:inDict[kMovie_poster_path]];
        _release_date = inDict[kMovie_release_date];
        _title = inDict[kMovie_title];
        
        _dictionary = inDict;
    }
    
    return self;
}

- (NSString*)createFullPosterPathWithLastComponent:(NSString*)last
{
    return [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w500%@", last];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", self.dictionary];
}

@end
