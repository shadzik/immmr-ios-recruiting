//
//  IMRCrew.m
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import "IMRCrew.h"

static NSString* const kCrew_job                = @"job";
static NSString* const kCrew_department         = @"department";
static NSString* const kCrew_creditid           = @"credit_id";

@interface IMRCrew ()

@property NSString *job;
@property NSString *department;
@property NSString *creditid;

@end

@implementation IMRCrew

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
    self.job = inDict[kCrew_job];
    self.department = inDict[kCrew_department];
    self.creditid = inDict[kCrew_creditid];
}

@end
