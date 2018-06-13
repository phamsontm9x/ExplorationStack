//
//  ExplorationViewController.m
//  ExplorationStack
//
//  Created by Son Pham on 6/13/18.
//  Copyright © 2018 Son Pham. All rights reserved.
//

#import "ExplorationViewController.h"
#import "ExplorationStackCollectionViewCell.h"
#import "ExplorationStackViewLayout.h"
#import "MangaInfoCollectionView.h"
#import "ExplorationStackViewTransition.h"
#import <QuartzCore/QuartzCore.h>
#import "ExplorationStackInteractiveTransitioning.h"



@interface ExplorationViewController () <ExplorationStackViewLayoutDelegate, MangaInfoCollectionViewDelegate, UIViewControllerTransitioningDelegate, UICollectionViewDelegate, UICollectionViewDataSource>


@property (nonatomic, strong) IBOutlet UIButton *btnLeft;
@property (nonatomic, strong) IBOutlet UIButton *btnRight;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) ExplorationStackViewLayout *layout;
@property (nonatomic) ExplorationStackViewTransition *transition;
@property (nonatomic) NSIndexPath *indexCell;
@property (nonatomic) BOOL fullScreen;
@property (nonatomic, strong) NSMutableArray *arrColor;

@end


@implementation ExplorationViewController

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
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
    cell.img.image = [UIImage imageNamed:@"mangainfo"];
    
    return cell;
}


#pragma mark - ExplorationStackViewLayoutDelegate

- (void)explorationStackViewLayout:(UICollectionViewLayout *)collectionViewLayout didFinishDraggingLeft:(BOOL)isLeft Right:(BOOL)isRight {
    _btnLeft.transform = CGAffineTransformMakeScale(1,1);
    _btnRight.transform = CGAffineTransformMakeScale(1,1);
}

- (void)explorationStackViewLayout:(UICollectionViewLayout *)collectionViewLayout updateDraggingLeft:(BOOL)isLeft Right:(BOOL)isRight {
    if (isLeft) {
        _btnLeft.transform = CGAffineTransformMakeScale(1.6, 1.6);
    } else {
        _btnLeft.transform = CGAffineTransformMakeScale(1,1);
    }
    
    if (isRight) {
        _btnRight.transform = CGAffineTransformMakeScale(1.6, 1.6);
    } else {
        _btnRight.transform = CGAffineTransformMakeScale(1,1);
    }
}

- (void)explorationStackViewLayout:(UICollectionViewLayout *)collectionViewLayout cellWillFullScreen:(NSIndexPath *)indexPath {
    
    _indexCell = indexPath;
    
    MangaInfoCollectionView *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:NSStringFromClass([MangaInfoCollectionView class])];
    vc.transitioningDelegate = self;
    vc.delegate = self;
    vc.numberOfRow = 5;
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


- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    ExplorationStackInteractiveTransitioning * transittion = [[ExplorationStackInteractiveTransitioning alloc] init];
    [transittion wireToViewController:self];
    
    return transittion;
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
