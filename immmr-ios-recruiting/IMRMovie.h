//
//  IMRMovie.h
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMRMovie : NSObject

/*
 adult = 0;
 "backdrop_path" = "/xVW8REyVqKwxAtUYY07UGlZH43L.jpg";
 "genre_ids" =             (
 18,
 14
 );
 id = 258230;
 "original_language" = en;
 "original_title" = "A Monster Calls";
 overview = "A boy attempts to deal with his mother's illness and the bullying of his classmates by escaping to a fantastical world.";
 popularity = "13.765676";
 "poster_path" = "/vdHUj9cyRe7fIYdJFMyc7elnawC.jpg";
 "release_date" = "2016-10-07";
 title = "A Monster Calls";
 video = 0;
 "vote_average" = "6.3";
 "vote_count" = 304;
 */

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
