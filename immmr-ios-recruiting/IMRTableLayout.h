//
//  IMRTableLayout.h
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMRTableLayout : UICollectionViewFlowLayout

- (CGSize)itemSizeForScreenWidth:(CGFloat)screenWidth;

@end
