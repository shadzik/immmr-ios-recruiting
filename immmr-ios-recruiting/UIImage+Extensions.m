//
//  UIImage+Extensions.m
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import "UIImage+Extensions.h"

@implementation UIImage (Extensions)

+ (UIImage *)drawCircleWithSize:(CGSize)size color:(UIColor*)color text:(NSString*)text fontSize:(CGFloat)fontSize
{
    static UIImage *circle = nil;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    //CGContextFillEllipseInRect(ctx, rect);
    CGContextFillRect(ctx, rect);
    
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGSize textSize = [text sizeWithAttributes:@{NSFontAttributeName:font}];
    CGRect textRect = CGRectIntegral(CGRectMake(size.width/2-textSize.width/2,
                                                size.height/2-textSize.height/2,
                                                size.width,
                                                size.height));
    [text drawInRect:textRect withAttributes:@{NSFontAttributeName:font,
                                               NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    CGContextRestoreGState(ctx);
    circle = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return circle;
}

- (UIImage *)squareImageWithSize:(CGSize)inSize
{
    CGFloat scale = MAX(inSize.width/self.size.width, inSize.height/self.size.height);
    CGFloat width = self.size.width * scale;
    CGFloat height = self.size.height * scale;
    
    CGRect rr = CGRectMake( 0, 0, width, height);
    
    UIGraphicsBeginImageContextWithOptions(inSize, NO, 0);
    [self drawInRect:rr];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
