//
//  IMRPerson.m
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import "IMRPerson.h"

static NSString* const kPerson_id             = @"id";
static NSString* const kPerson_name           = @"name";
static NSString* const kPerson_profile_path   = @"profile_path";


@interface IMRPerson ()

@property NSString *personid;
@property NSString *name;
@property NSString *profile_path;

@property NSDictionary *dictionary;

@end

@implementation IMRPerson

- (instancetype)initWithDictionary:(NSDictionary*)inDict
{
    self = [super init];
    if (self)
    {
        _personid = inDict[kPerson_id];
        _name = inDict[kPerson_name];
        _profile_path = [self createFullPathWithLastComponent:inDict[kPerson_profile_path]];
        
        _dictionary = inDict;
    }
    
    return self;
}

- (NSString*)createFullPathWithLastComponent:(NSString*)last
{
    if (!last) {
        return nil;
    }
    
    return [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w185%@", last];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", self.dictionary];
}

@end
