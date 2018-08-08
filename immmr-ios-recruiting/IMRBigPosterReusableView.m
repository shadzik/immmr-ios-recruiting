//
//  IMRBigPosterReusableView.m
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import "IMRBigPosterReusableView.h"

@interface IMRBigPosterReusableView ()

@property IBOutlet NSLayoutConstraint *posterImageViewCenterConstraint;

@end

@implementation IMRBigPosterReusableView

- (void)updateWithOffset:(CGPoint)offset
{
    self.posterImageViewCenterConstraint.constant = -offset.y;
}

@end
