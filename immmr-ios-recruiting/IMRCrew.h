//
//  IMRCrew.h
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import "IMRPerson.h"

@interface IMRCrew : IMRPerson

@property (readonly) NSString *job;
@property (readonly) NSString *department;
@property (readonly) NSString *creditid;

- (instancetype)initWithDictionary:(NSDictionary*)inDict NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end
