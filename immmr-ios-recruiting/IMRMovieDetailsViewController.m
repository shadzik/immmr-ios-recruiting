//
//  IMRMovieDetailsViewController.m
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import "IMRMovieDetailsViewController.h"
#import "IMRMovie.h"
#import "IMRMovieDetailsViewModel.h"
#import "IMRBigPosterReusableView.h"
#import "IMRSectionReusableView.h"
#import "IMRPersonCollectionViewCell.h"
#import "IMRPlotCollectionViewCell.h"
#import "IMRTableLayout.h"

#import "IMRCast.h"
#import "IMRCrew.h"

#import <ReactiveObjC/ReactiveObjC.h>

static NSString * const castIdentifier = @"kCastCell";
static NSString * const plotIdentifier = @"kPlotCell";
static NSString * const headerReuseIdentifier = @"kBigPosterHeaderView";
static NSString * const sectionReuseIdentifier = @"kSectionView";

@interface IMRMovieDetailsViewController () <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

@property IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) IMRMovieDetailsViewModel *viewModel;

@end

@implementation IMRMovieDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.movie.title;
    
    self.viewModel = [[IMRMovieDetailsViewModel alloc] initWithAPIClient:self.apiClient movie:self.movie];
    
    UINib *castNib = [UINib nibWithNibName:@"IMRPersonCollectionViewCell" bundle:nil];
    UINib *plotNib = [UINib nibWithNibName:@"IMRPlotCollectionViewCell" bundle:nil];
    UINib *headerNib = [UINib nibWithNibName:@"IMRBigPosterReusableView" bundle:nil];
    UINib *sectionNib = [UINib nibWithNibName:@"IMRSectionReusableView" bundle:nil];
    [self.collectionView registerNib:castNib forCellWithReuseIdentifier:castIdentifier];
    [self.collectionView registerNib:plotNib forCellWithReuseIdentifier:plotIdentifier];
    [self.collectionView registerNib:headerNib
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:headerReuseIdentifier];
    [self.collectionView registerNib:sectionNib
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:sectionReuseIdentifier];
    
    @weakify(self)
    [self.viewModel.reloadDataSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.collectionView reloadData];
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.viewModel.numberOfSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.viewModel numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    IMRPersonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:castIdentifier forIndexPath:indexPath];

    if (section == IMRMovieDetailsSection_director) {
        IMRCrew *director = self.viewModel.directors[indexPath.row];
        cell.person = director;
        return cell;
    } else if (section == IMRMovieDetailsSection_cast) {
        
        if (!self.viewModel.shouldShowFullCast && indexPath.row == shortCastNumber)
        {
            IMRCast *fakeCast = [[IMRCast alloc] initWithDictionary:@{
                                                                      @"name" : NSLocalizedString(@"Show more...", @"show more"),
                                                                      @"character" : @""
                                                                      }];
            cell.person = fakeCast;
            cell.posterImageView.hidden = YES;
            return cell;
        }
        
        IMRCast *cast = self.viewModel.cast[indexPath.row];
        cell.person = cast;
        return cell;
    } else if (section == IMRMovieDetailsSection_overview) {
        IMRPlotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:plotIdentifier forIndexPath:indexPath];
        
        cell.plot.text = self.movie.overview;
        
        return cell;
    }
        
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.viewModel.shouldShowFullCast && indexPath.row == shortCastNumber)
    {
        self.viewModel.shouldShowFullCast = !self.viewModel.shouldShowFullCast;
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:IMRMovieDetailsSection_cast]];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat height = 30;
    
    switch (section)
    {
        case IMRMovieDetailsSection_header:
        {
            CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
            height = (width+20) * 1.5;
        }
            break;
    }
    
    return CGSizeMake(self.collectionView.frame.size.width, height);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader)
    {
        if (indexPath.section == IMRMovieDetailsSection_header)
        {
            IMRBigPosterReusableView *bigPosterView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                                  withReuseIdentifier:headerReuseIdentifier
                                                                                                         forIndexPath:indexPath];

            bigPosterView.bigPosterImageView.image = self.poster;
            
            return bigPosterView;
        }
        else
        {
            IMRSectionReusableView *sectionView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                              withReuseIdentifier:sectionReuseIdentifier
                                                                                                     forIndexPath:indexPath];
            if (indexPath.section == IMRMovieDetailsSection_director) {
                sectionView.title.text = NSLocalizedString(@"Director", @"director");
            } else if (indexPath.section == IMRMovieDetailsSection_cast) {
                sectionView.title.text = NSLocalizedString(@"Cast", @"cast");
            } else if (indexPath.section == IMRMovieDetailsSection_overview) {
                sectionView.title.text = NSLocalizedString(@"Plot", @"plot");
            }
            
            return sectionView;
        }
        
    }
    
    return nil;
}

#pragma mark - FlowLayout Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = [((IMRTableLayout*)collectionViewLayout) itemSizeForScreenWidth:self.collectionView.bounds.size.width];
    
    if (indexPath.section == IMRMovieDetailsSection_overview) {
        size.height = [self heightForString:self.movie.overview font:[UIFont systemFontOfSize:17]];
    }
    
    return size;
}

- (CGFloat)heightForString:(NSString*)inString font:(UIFont*)inFont
{
    CGSize constraint = CGSizeMake(280, MAXFLOAT);
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:inFont forKey:NSFontAttributeName];
    CGRect textsize = [inString boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return textsize.size.height;
}

#pragma mark - ScrollView Paralax

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSArray *subviews = self.collectionView.subviews;
    
    for (UIView *view in subviews)
    {
        if ([view isKindOfClass:[IMRBigPosterReusableView class]])
        {
            CGRect bounds = self.collectionView.bounds;
            CGPoint boundsCenter = CGPointMake(CGRectGetMidX(bounds),
                                               CGRectGetMidY(bounds));
            CGPoint cellCenter = view.center;
            CGPoint offsetFromCenter =
            CGPointMake(boundsCenter.x - cellCenter.x,
                        boundsCenter.y - cellCenter.y);
            
            CGSize cellSize = view.bounds.size;
            CGFloat maxVerticalOffset =
            (bounds.size.height / 2) + (cellSize.height / 2);
            CGFloat scaleFactor = 30. / maxVerticalOffset;
            
            CGPoint parallaxOffset = CGPointMake(0.0, -offsetFromCenter.y * scaleFactor);
            [(IMRBigPosterReusableView*)view updateWithOffset:parallaxOffset];
        }
    }
}

@end
