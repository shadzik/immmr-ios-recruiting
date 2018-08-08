//
//  IMRMovieDetailsViewController.h
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IMRMovie;
@class IMRMovieAPIClient;

@interface IMRMovieDetailsViewController : UIViewController

@property (nonatomic, strong) IMRMovie *movie;
@property (nonatomic, strong) IMRMovieAPIClient *apiClient;
@property (nonatomic, strong) UIImage *poster;

@end
