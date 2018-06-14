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



@interface MangaInfoCollectionView () <UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) NSMutableArray *arrColor;

@end

@implementation MangaInfoCollectionView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    CGPoint vel = [scrollView.panGestureRecognizer velocityInView:scrollView.panGestureRecognizer.view];
    
    if (scrollView.contentOffset.y == -scrollView.adjustedContentInset.top && vel.y > 0) {
        self.interactiveTransition.interactionInProgress = YES;
    } else {
        self.interactiveTransition.interactionInProgress = NO;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

}

@end
