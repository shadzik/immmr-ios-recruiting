//
//  IMRPerson.h
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMRPerson : NSObject

@property (readonly) NSString *personid;
@property (readonly) NSString *name;
@property (readonly) NSString *profile_path;

@property (readonly) NSDictionary *dictionary;

- (instancetype)initWithDictionary:(NSDictionary*)inDict NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end
