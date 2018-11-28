//
//  IMRPerson.h
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMRPerson : NSObject

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
 ],
 "crew": [
 {
 "credit_id": "52fe422ac3a36847f8008fd5",
 "department": "Directing",
 "id": 648,
 "job": "Director",
 "name": "Philip Kaufman",
 "profile_path": "/5hmDqd4AoGgDnAb18L6JcjtqlmK.jpg"
 },
 */

@property (readonly) NSString *personid;
@property (readonly) NSString *name;
@property (readonly) NSString *profile_path;

@property (readonly) NSDictionary *dictionary;

- (instancetype)initWithDictionary:(NSDictionary*)inDict NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end
