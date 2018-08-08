//
//  UIImage+Extensions.h
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extensions)

+ (UIImage *)drawCircleWithSize:(CGSize)size color:(UIColor*)color text:(NSString*)text fontSize:(CGFloat)fontSize;
- (UIImage *)squareImageWithSize:(CGSize)inSize;

@end
