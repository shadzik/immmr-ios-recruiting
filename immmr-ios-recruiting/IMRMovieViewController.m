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
@property (nonatomic, strong) IMRMovieAPIClient *client;
@property (nonatomic, strong) IMRMovieViewModel *viewModel;
@property (nonatomic, strong) IMRMovie *selectedMovie;

@property (nonatomic, strong) NSDictionary *imageCache;

@end

@implementation IMRMovieViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Register cell classes
    UINib *nib = [UINib nibWithNibName:@"IMRMovieCollectionViewCell" bundle: nil];
    [self.collectionView registerNib:nib
          forCellWithReuseIdentifier:reuseIdentifier];
    
//    IMRMovieAPIClient *client = [IMRMovieAPIClient sharedAPIClient];
    self.client = [[IMRMovieAPIClient alloc] init];
    self.viewModel = [[IMRMovieViewModel alloc] initWithAPIClient:self.client];
    
    @weakify(self)
    [self.viewModel.reloadDataSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.collectionView reloadData];
    }];
    
//    @weakify(self)
//    [client getNowPlayingMovies:^(NSDictionary *result) {
//        
//        @strongify(self)
//        NSArray *movieArray = result[@"results"];
//        
//        self.nowPlayingMovies = [movieArray ma_map:^id(id obj) {
//            IMRMovie *movie = [[IMRMovie alloc] initWithDictionary:obj];
//            return movie;
//        }];
//        
//        [self.collectionView reloadData];
//    }];
    
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
//    return 1;
    return self.viewModel.numberOfSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return self.nowPlayingMovies.count;
    return [self.viewModel numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSUInteger nodeCount = self.nowPlayingMovies.count;
    NSUInteger nodeCount = self.viewModel.nowPlayingMovies.count;

    IMRMovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (nodeCount > 0)
    {
//        IMRMovie *movie = self.nowPlayingMovies[indexPath.row];
        IMRMovie *movie = self.viewModel.nowPlayingMovies[indexPath.row];
        cell.movie = movie;
        
        [cell.imageDownloadFinishedSignal subscribeNext:^(NSDictionary *dict) {
            NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:dict];
            [mutableDict addEntriesFromDictionary:self.imageCache];
            self.imageCache = [mutableDict copy];
        }];
        
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedMovie = self.viewModel.nowPlayingMovies[indexPath.row];
    [self performSegueWithIdentifier:@"showMovieDetails" sender:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showMovieDetails"])
    {
        IMRMovieDetailsViewController *nextController = (IMRMovieDetailsViewController*)segue.destinationViewController;
        nextController.movie = self.selectedMovie;
        nextController.apiClient = self.client;
        nextController.poster = self.imageCache[self.selectedMovie.movieid];
    }
}

@end
