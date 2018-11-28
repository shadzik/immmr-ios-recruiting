//
//  IMRCast.h
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import "IMRPerson.h"

@interface IMRCast : IMRPerson
/*
 {
 "cast_id": 29,
 "character": "Terri Perri",
 "credit_id": "52fe422ac3a36847f8009057",
 "id": 3021,
 "name": "Terri Perri",
 "order": 18,
 "profile_path": null
 }
 */

@property (readonly) NSString *castid;
@property (readonly) NSString *character;
@property (readonly) NSString *creditid;

- (instancetype)initWithDictionary:(NSDictionary*)inDict NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;


@end
