//
//  IMRTableLayout.m
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import "IMRTableLayout.h"

@implementation IMRTableLayout

- (void)prepareLayout
{
    CGFloat width = CGRectGetWidth(self.collectionView.frame) - self.collectionView.contentInset.left - self.collectionView.contentInset.right;
    
    self.minimumInteritemSpacing = 8;
    self.minimumLineSpacing      = 1;
    self.itemSize                = [self itemSizeForScreenWidth:width];
}

- (CGSize)itemSizeForScreenWidth:(CGFloat)screenWidth
{
    CGFloat itemWidth  = screenWidth - self.sectionInset.right - self.sectionInset.left;
    CGFloat itemHeight = 80;
    return CGSizeMake(itemWidth, itemHeight);
}

@end
