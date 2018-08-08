//
//  IMRCast.h
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import "IMRPerson.h"

@interface IMRCast : IMRPerson

@property (readonly) NSString *castid;
@property (readonly) NSString *character;
@property (readonly) NSString *creditid;

- (instancetype)initWithDictionary:(NSDictionary*)inDict NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;


@end
