//
//  IMRMovieViewModel.h
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MACollectionUtilities/MACollectionUtilities.h>
#import <ReactiveObjC/ReactiveObjC.h>

@class IMRMovieAPIClient;

@interface IMRMovieViewModel : NSObject

- (instancetype)initWithAPIClient:(IMRMovieAPIClient*)apiClient NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (void)getNowPlayingMovies;

@property (nonatomic, strong) RACSubject *reloadDataSignal;
@property (readonly) NSArray *nowPlayingMovies;

@end
