//
//  IMRCrew.h
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import "IMRPerson.h"

@interface IMRCrew : IMRPerson

/*
{
    "credit_id": "52fe422ac3a36847f8008fd5",
    "department": "Directing",
    "id": 648,
    "job": "Director",
    "name": "Philip Kaufman",
    "profile_path": "/5hmDqd4AoGgDnAb18L6JcjtqlmK.jpg"
},
*/

@property (readonly) NSString *job;
@property (readonly) NSString *department;
@property (readonly) NSString *creditid;

- (instancetype)initWithDictionary:(NSDictionary*)inDict NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end
