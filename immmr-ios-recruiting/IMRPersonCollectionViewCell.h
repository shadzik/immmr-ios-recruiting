//
//  IMRPersonCollectionViewCell.h
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IMRPerson;

@interface IMRPersonCollectionViewCell : UICollectionViewCell

@property (weak) IBOutlet UIImageView *posterImageView;
@property (nonatomic, strong) IMRPerson *person;

@end
