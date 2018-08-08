//
//  IMRPersonCollectionViewCell.m
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import "IMRPersonCollectionViewCell.h"
#import "IMRPerson.h"
#import "IMRCast.h"
#import "UIImage+Extensions.h"
#import "NSString+Extensions.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface IMRPersonCollectionViewCell ()

@property (weak) IBOutlet UILabel *name;
@property (weak) IBOutlet UILabel *role;

@end

@implementation IMRPersonCollectionViewCell

-  (void)awakeFromNib
{
    [super awakeFromNib];

    // Do we need this? Maybe we do (Hint: Exercise 4)
}

- (void)setPerson:(IMRPerson *)person
{
    _person = person;
    
    self.name.text = person.name;
    self.role.text = @"";
    if ([person isKindOfClass:[IMRCast class]]) {
        if (![((IMRCast*)person).character isEqualToString:@""]) {
            self.role.text = [NSString stringWithFormat:@"as %@", ((IMRCast*)person).character];
        }
    }
    
    UIImage *placeholderImage;
    
    NSURL *url = [NSURL URLWithString:person.profile_path];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];

    @weakify(self)
    [self.posterImageView sd_setImageWithURL:url
                            placeholderImage:placeholderImage
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                       @strongify(self)
                                       
                                       if (error) {
                                           self.posterImageView.image = placeholderImage;
                                       } else {
                                           self.posterImageView.alpha = 0;
                                           self.posterImageView.image = image;
                                           
                                           [UIView transitionWithView:self.posterImageView
                                                             duration:0.5f
                                                              options:UIViewAnimationOptionTransitionCrossDissolve
                                                           animations:^{
                                                               self.posterImageView.alpha = 1.0;
                                                               [self setNeedsLayout];
                                                           } completion:nil];
                                       }
                                   }];
}

@end
