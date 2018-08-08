//
//  IMRMovieDetailsViewModel.h
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MACollectionUtilities/MACollectionUtilities.h>
#import <ReactiveObjC/ReactiveObjC.h>

@class IMRMovieAPIClient;
@class IMRMovie;

typedef NS_ENUM(NSInteger, IMRMovieDetailsSections)
{
    IMRMovieDetailsSection_header,
    IMRMovieDetailsSection_overview,
    IMRMovieDetailsSection_director,
    IMRMovieDetailsSection_cast,
    
    IMRMovieDetailsSections_count
};

extern NSInteger const shortCastNumber;

@interface IMRMovieDetailsViewModel : NSObject

- (instancetype)initWithAPIClient:(IMRMovieAPIClient*)apiClient movie:(IMRMovie*)movie NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;

@property (nonatomic, strong) RACSubject *reloadDataSignal;
@property (readonly) NSArray *cast;
@property (readonly) NSArray *directors;

@property (nonatomic, assign) BOOL shouldShowFullCast;

@end
