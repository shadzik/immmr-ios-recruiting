//
//  IMRMovieViewController.m
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 18/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import "IMRMovieViewController.h"
#import "IMRMovieAPIClient.h"
#import "IMRMovie.h"
#import "IMRMovieCollectionViewCell.h"
#import "IMRMovieViewModel.h"
#import "IMRMovieDetailsViewController.h"

#import <MACollectionUtilities/MACollectionUtilities.h>
#import <ReactiveObjC/ReactiveObjC.h>

static NSString * const reuseIdentifier = @"kMovieCell";

@interface IMRMovieViewController () <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

@property IBOutlet UICollectionView *collectionView;

@property NSArray *nowPlayingMovies;
// needed for Exercise 2
//@property (nonatomic, strong) IMRMovieAPIClient *client;
//@property (nonatomic, strong) IMRMovieViewModel *viewModel;
@property (nonatomic, strong) IMRMovie *selectedMovie;

@property (nonatomic, strong) NSDictionary *imageCache;

@end

@implementation IMRMovieViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"IMRMovieCollectionViewCell" bundle: nil];
    [self.collectionView registerNib:nib
          forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IMRMovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedMovie = nil;
    [self performSegueWithIdentifier:@"showMovieDetails" sender:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showMovieDetails"])
    {
    }
}

@end
