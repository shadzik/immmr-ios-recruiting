//
//  IMRMovieCollectionViewCell.m
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import "IMRMovieCollectionViewCell.h"
#import "IMRMovie.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import <ReactiveObjC/ReactiveObjC.h>

@implementation IMRMovieCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.imageDownloadFinishedSignal = [[RACSubject subject] setNameWithFormat:@"IMRMovieCollectionViewCell downloadFinished"];
}

- (void)setMovie:(IMRMovie *)movie
{
    _movie = movie;
    
    NSURL *url = [NSURL URLWithString:movie.poster_path];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    
    @weakify(self)
    [self.coverImageView sd_setImageWithURL:url
                           placeholderImage:[UIImage imageNamed:@"movie-placeholder"]
                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                      @strongify(self)
                                      
                                      if (error) {
                                          self.coverImageView.image = [UIImage imageNamed:@"movie-placeholder"];
                                      } else {
                                          self.coverImageView.alpha = 0;
                                          self.coverImageView.image = image;
                                          
                                          [UIView transitionWithView:self.coverImageView
                                                            duration:0.5f
                                                             options:UIViewAnimationOptionTransitionCrossDissolve
                                                          animations:^{
                                                              self.coverImageView.alpha = 1.0;
                                                              [self setNeedsLayout];
                                                          } completion:nil];
                                      }
                                      
                                      [self.imageDownloadFinishedSignal sendNext:@{ movie.movieid : self.coverImageView.image }];
                                  }];
}

@end
