//
//  TTPhotoSelectViewController.m
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-18.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import "TTPhotoSelectViewController.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import "TTPhotoCollectionViewCell.h"
#import "TTPhotoEditViewController.h"

@interface TTPhotoSelectViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) ALAssetsGroup *assetsGroup;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation TTPhotoSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photos = [NSMutableArray new];
    self.selectedIndex = NSIntegerMax;
    [self loadPhotos];
}

- (void)loadPhotos
{
    [self loadAssetsGroup];
}

- (void)loadAssetsGroup
{
    self.assetsLibrary = [ALAssetsLibrary new];
    typeof(self) weakSelf = self;
    @autoreleasepool {
        [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            if (*stop || !group) {
                [weakSelf loadPhotosFromAssetGroup];
            }

            if ([[group valueForProperty:ALAssetsGroupPropertyType] intValue] == ALAssetsGroupSavedPhotos) {
                weakSelf.assetsGroup = group;
            }
        } failureBlock:^(NSError *error) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请进入系统“设置”>“隐私”>“照片”，允许“两万番茄”访问你的照片" preferredStyle:UIAlertControllerStyleAlert];
            [weakSelf showViewController:alertController sender:nil];
        }];
    }
}

- (void)loadPhotosFromAssetGroup
{
    if (self.assetsGroup) {
        [self.assetsGroup setAssetsFilter:[ALAssetsFilter allPhotos]];
        [self.assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (*stop || !result) {
                return ;
            }

            [self.photos addObject:result];
        }];
        [self.collectionView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UICollectionViewDataSource delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TTPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TTPhotoCollectionViewCell" forIndexPath:indexPath];
    ALAsset *asset = self.photos[indexPath.row];
    cell.imageView.image = [UIImage imageWithCGImage:asset.thumbnail];
    return cell;
}

#pragma mark - UICollectionViewDelegate delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"TTPhotoEditViewController" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[TTPhotoEditViewController class]]) {
        TTPhotoEditViewController *photoEditViewController = (TTPhotoEditViewController *) segue.destinationViewController;
        ALAsset *selectedAsset = self.photos[self.selectedIndex];
        photoEditViewController.originImage = [UIImage imageWithCGImage:[[selectedAsset defaultRepresentation] fullResolutionImage]];
    }
}

@end
