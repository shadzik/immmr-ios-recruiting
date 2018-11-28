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
    
    self.posterImageView.layer.cornerRadius = self.posterImageView.frame.size.width/2;
    self.posterImageView.clipsToBounds = YES;
    self.posterImageView.hidden = NO;
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
    
    UIImage *placeholderImage = [UIImage drawCircleWithSize:self.posterImageView.frame.size
                                                      color:[UIColor darkGrayColor]
                                                       text:[self.name.text getInitials]
                                                   fontSize:self.name.font.pointSize];
    
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
                                           self.posterImageView.image = [image squareImageWithSize:self.posterImageView.frame.size];
                                           
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

// we could remove this code to provoke a bug
// in which the UIImageView gets hidden for the "Show more" cell
// and then gets reused
- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.posterImageView.image = nil;
    self.posterImageView.hidden = NO;
    self.posterImageView.alpha = 1.0;
}


@end
