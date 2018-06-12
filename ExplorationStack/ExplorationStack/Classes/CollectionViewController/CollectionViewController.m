//
//  CollectionViewController.m
//  ExplorationStack
//
//  Created by Son Pham on 6/8/18.
//  Copyright © 2018 Son Pham. All rights reserved.
//

#import "CollectionViewController.h"
#import "ExplorationStackCollectionViewCell.h"
#import "ExplorationStackViewLayout.h"
#import "MangaInfoCollectionView.h"
#import "ExplorationStackViewTransition.h"
#import <QuartzCore/QuartzCore.h>



@interface CollectionViewController () <ExplorationStackViewLayoutDelegate, MangaInfoCollectionViewDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) NSMutableArray *arrColor;
@property (nonatomic, strong) UIButton *btnLeft;
@property (nonatomic, strong) UIButton *btnRight;
@property (nonatomic, strong) ExplorationStackViewLayout *layout;
@property (nonatomic, strong) ExplorationStackViewTransition *transition;
@property (nonatomic) NSIndexPath *indexCell;
@property (nonatomic) BOOL fullScreen;

@end

@implementation CollectionViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.transitioningDelegate = self;
    
    _indexCell  = 0;
    _fullScreen = NO;
    _arrColor = [[NSMutableArray alloc] init];
    [_arrColor addObject:[UIColor grayColor]];
    [_arrColor addObject:[UIColor blueColor]];
    [_arrColor addObject:[UIColor yellowColor]];
    [_arrColor addObject:[UIColor magentaColor]];
    
    _layout = [[ExplorationStackViewLayout alloc] init];
    self.collectionView.collectionViewLayout = _layout;
    [self.collectionView setScrollEnabled:NO];
    _layout.delegateDrag = self;
    _layout.gesturesEnabled = YES;
    
    [self.collectionView reloadData];
    
    _btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(-10, self.collectionView.frame.size.height/2, 40, 40)];
    [_btnLeft setBackgroundImage:[UIImage imageNamed:@"ic_delete"] forState:UIControlStateNormal];
    
    _btnRight = [[UIButton alloc] initWithFrame:CGRectMake(self.collectionView.frame.size.width - 30, self.collectionView.frame.size.height/2, 40, 40)];
    [_btnRight setBackgroundImage:[UIImage imageNamed:@"ic_select"] forState:UIControlStateNormal];
    
    [self.collectionView addSubview:_btnLeft];
    [self.collectionView addSubview:_btnRight];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {

    [_btnLeft setFrame:CGRectMake(-10 , size.height/2, 40, 40)];
    [_btnRight setFrame:CGRectMake(size.width - 30, size.height/2, 40, 40)];
    [self.collectionView reloadData];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ExplorationStackCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ExplorationStackCollectionViewCell" forIndexPath:indexPath];
    cell.titleLabel.text = [NSString stringWithFormat:@"View %ld",indexPath.row];
    cell.backgroundColor = _arrColor[indexPath.row%4];
    
    return cell;
}


#pragma mark - ExplorationStackViewLayoutDelegate

- (void)explorationStackViewLayout:(UICollectionViewLayout *)collectionViewLayout didFinishDraggingLeft:(BOOL)isLeft Right:(BOOL)isRight {
    _btnLeft.transform = CGAffineTransformMakeScale(1,1);
    _btnRight.transform = CGAffineTransformMakeScale(1,1);
}

- (void)explorationStackViewLayout:(UICollectionViewLayout *)collectionViewLayout updateDraggingLeft:(BOOL)isLeft Right:(BOOL)isRight {
    if (isLeft) {
        _btnLeft.transform = CGAffineTransformMakeScale(1.4, 1.4);
    } else {
        _btnLeft.transform = CGAffineTransformMakeScale(1,1);
    }
    
    if (isRight) {
        _btnRight.transform = CGAffineTransformMakeScale(1.4, 1.4);
    } else {
        _btnRight.transform = CGAffineTransformMakeScale(1,1);
    }
}

- (void)explorationStackViewLayout:(UICollectionViewLayout *)collectionViewLayout cellWillFullScreen:(NSIndexPath *)indexPath {
   
    _indexCell = indexPath;
    
    MangaInfoCollectionView *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:NSStringFromClass([MangaInfoCollectionView class])];
    vc.transitioningDelegate = self;
    vc.color = _arrColor[indexPath.row];
    vc.delegate = self;
    [vc.collectionView setScrollEnabled:YES];
    [self presentViewController:vc animated:YES completion:nil];
}


- (void)mangaInfoCollectionView:(MangaInfoCollectionView *)vc didSmallScreen:(NSIndexPath *)indexPath {

}

- (CGRect)getFrameCellAtIndexPath:(NSIndexPath*)indexPath {
    UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath];
    
    return attributes.frame;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    _transition = [[ExplorationStackViewTransition alloc] init];
    _transition.reverse = NO;
    _transition.fromViewDefault = [self getFrameCellAtIndexPath:_indexCell];
    _transition.snapShot = [[UIImageView alloc] initWithFrame:_transition.fromViewDefault];
    _transition.snapShot.image = [self captureViewWithFrame:_transition.fromViewDefault];
    _transition.snapShot.contentMode = UIViewContentModeScaleAspectFit;
    return _transition;
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {

    _transition = [[ExplorationStackViewTransition alloc] init];
    _transition.reverse = YES;
    _transition.fromViewDefault = [self getFrameCellAtIndexPath:_indexCell];
    _transition.snapShot = [[UIImageView alloc] initWithFrame:_transition.fromViewDefault];
    _transition.snapShot.image = [self captureViewWithFrame:_transition.fromViewDefault];
    _transition.snapShot.contentMode = UIViewContentModeScaleAspectFit;
    return _transition;
}


#pragma mark - UIImage

- (UIImage*)captureViewWithFrame:(CGRect)frame {
    
    ExplorationStackCollectionViewCell *cell = (ExplorationStackCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:_indexCell];
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [cell.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;

}


@end
