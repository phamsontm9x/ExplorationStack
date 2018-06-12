//
//  MangaInfoCollectionView.m
//  ExplorationStack
//
//  Created by Son Pham on 6/11/18.
//  Copyright © 2018 Son Pham. All rights reserved.
//

#import "MangaInfoCollectionView.h"

@interface MangaInfoCollectionView () <UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *arrColor;
@property (nonatomic) BOOL isTopScrollView;

@end

@implementation MangaInfoCollectionView

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isTopScrollView = NO;
    _arrColor = [[NSMutableArray alloc] init];
    [_arrColor addObject:[UIColor grayColor]];
    [_arrColor addObject:[UIColor blueColor]];
    [_arrColor addObject:[UIColor yellowColor]];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)didChangeModeFullScreen {
    
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.backgroundColor = _color;
    } else {
        cell.backgroundColor = _arrColor[indexPath.row%3];
    }
    
    
    // Configure the cell
    
    return cell;
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < -50 && _isTopScrollView) {
        __strong typeof(_delegate) delegate = _delegate;
        if (delegate && [delegate respondsToSelector:@selector(mangaInfoCollectionView:didSmallScreen:)]) {
            _isTopScrollView = NO;
            [delegate mangaInfoCollectionView:self didSmallScreen:nil];
        }
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
