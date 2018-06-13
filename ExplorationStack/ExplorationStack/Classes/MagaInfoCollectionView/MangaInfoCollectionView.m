//
//  MangaInfoCollectionView.m
//  ExplorationStack
//
//  Created by Son Pham on 6/11/18.
//  Copyright © 2018 Son Pham. All rights reserved.
//

#import "MangaInfoCollectionView.h"
#import "ExplorationStackViewTransition.h"
#import "ExplorationStackCollectionViewCell.h"

@interface MangaInfoCollectionView () <UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *arrColor;
@property (nonatomic) BOOL isTopScrollView;

@end

@implementation MangaInfoCollectionView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isTopScrollView = NO;
    self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self.collectionView setScrollEnabled:YES];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _numberOfRow;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ExplorationStackCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ExplorationStackCollectionViewCell" forIndexPath:indexPath];
    cell.img.image = [UIImage imageNamed:@"mangainfo"];
    
    return cell;
}


#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < -scrollView.adjustedContentInset.top && _isTopScrollView) {
        [self.collectionView setScrollEnabled:NO];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y == -scrollView.adjustedContentInset.top) {
        _isTopScrollView = YES;
    } else {
        _isTopScrollView = NO;
    }
}

@end
