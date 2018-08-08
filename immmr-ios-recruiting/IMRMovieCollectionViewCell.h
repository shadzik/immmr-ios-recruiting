//
//  IMRMovieCollectionViewCell.h
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

@class IMRMovie;

@interface IMRMovieCollectionViewCell : UICollectionViewCell

@property IBOutlet UIImageView *coverImageView;
@property (nonatomic, strong) IMRMovie *movie;

@property (nonatomic, strong) RACSubject *imageDownloadFinishedSignal;

@end
