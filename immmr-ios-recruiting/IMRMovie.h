//
//  IMRMovie.h
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMRMovie : NSObject

@property (readonly) NSString *movieid;
@property (readonly) NSString *original_title;
@property (readonly) NSString *overview;
@property (readonly) NSString *poster_path;
@property (readonly) NSString *release_date;
@property (readonly) NSString *title;

@property (readonly) NSDictionary *dictionary;

- (instancetype)initWithDictionary:(NSDictionary*)inDict NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end
