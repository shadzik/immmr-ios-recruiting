//
//  IMRGridLayout.m
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import "IMRGridLayout.h"

#pragma mark Constants
const CGFloat kGridNumItems     = 3; //items per row
const CGFloat kGridItemSpacing  = 5;
const CGFloat kGridOuterSpacing = 0;
const CGFloat kGridImagePadding = 5;

@implementation IMRGridLayout

- (void)prepareLayout
{
    CGFloat width = CGRectGetWidth(self.collectionView.frame) - self.collectionView.contentInset.left - self.collectionView.contentInset.right;
    
    self.sectionInset            = UIEdgeInsetsMake(kGridItemSpacing, kGridOuterSpacing, kGridOuterSpacing, kGridOuterSpacing);
    self.minimumInteritemSpacing = kGridItemSpacing;
    self.minimumLineSpacing      = kGridItemSpacing;
    self.itemSize                = [self itemSizeForScreenWidth:width];
}

- (CGSize)imageSizeForScreenWidth:(CGFloat)screenWidth
{
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize itemSize = [self itemSizeForScreenWidth:screenWidth];
    CGSize imageSize = CGSizeMake((itemSize.width - kGridImagePadding)*scale, (itemSize.height - kGridImagePadding)*scale);
    return imageSize;
}

- (CGSize)itemSizeForScreenWidth:(CGFloat)screenWidth
{
    CGFloat itemWidth  = floor((screenWidth - self.sectionInset.right - self.sectionInset.left - (kGridNumItems-1) * kGridItemSpacing) / kGridNumItems);
    CGFloat itemHeight = floor(itemWidth * 1.5);
    return CGSizeMake(itemWidth, itemHeight);
}

//fix for wrong occuring cells with AZ-Bar
//http://stackoverflow.com/questions/12927027/uicollectionview-flowlayout-not-wrapping-cells-correctly-ios/13389461#13389461
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *newAttributes = [NSMutableArray arrayWithCapacity:attributes.count];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        
        if ((CGRectGetMaxX(attribute.frame) <= self.collectionViewContentSize.width) &&
            (CGRectGetMaxY(attribute.frame) <= self.collectionViewContentSize.height))
        {
            [newAttributes addObject:attribute];
        }
    }
    return newAttributes;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes* attributes = [super layoutAttributesForSupplementaryViewOfKind:elementKind atIndexPath:indexPath];
    if (attributes.zIndex != 1)
    {
        attributes.zIndex = 1;
    }
    return attributes;
}

@end
