//
//  IMRCast.m
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import "IMRCast.h"

static NSString* const kCast_castid         = @"cast_id";
static NSString* const kCast_character      = @"character";
static NSString* const kCast_creditid       = @"credit_id";

@interface IMRCast ()

@property NSString *castid;
@property NSString *character;
@property NSString *creditid;

@end

@implementation IMRCast

- (instancetype)initWithDictionary:(NSDictionary *)inDict
{
    self = [super initWithDictionary:inDict];
    if (self) {
        [self updateWithDict:inDict];
    }
    
    return self;
}

- (void)updateWithDict:(NSDictionary*)inDict
{
    self.castid = inDict[kCast_castid];
    self.character = inDict[kCast_character];
    self.creditid = inDict[kCast_creditid];
}

@end
