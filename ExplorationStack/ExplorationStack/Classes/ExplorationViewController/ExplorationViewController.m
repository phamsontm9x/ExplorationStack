//
//  ExplorationViewController.m
//  ExplorationStack
//
//  Created by Son Pham on 6/13/18.
//  Copyright © 2018 Son Pham. All rights reserved.
//

#import "ExplorationViewController.h"
#import "ExplorationStackCollectionViewCell.h"
#import "ExplorationStackCollectionViewCell.h"
#import "MangaInfoCollectionView.h"
#import "ExplorationStackViewTransition.h"
#import <QuartzCore/QuartzCore.h>
#import "ExplorationStackInteractiveTransitioning.h"
#import "ExplorationStackViewLayout.h"


#warning check value
__const NSInteger minimumXPanDistanceToSwipe = 100;

@interface ExplorationViewController () <MangaInfoCollectionViewDelegate, UIViewControllerTransitioningDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate>

// IBOutlet
@property (nonatomic, strong) IBOutlet UIButton *btnLeft;
@property (nonatomic, strong) IBOutlet UIButton *btnRight;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;

// Transition
@property (nonatomic, strong) ExplorationStackViewTransition *transition;
@property (nonatomic, strong) ExplorationStackInteractiveTransitioning *interactiveTransition;
@property (nonatomic, strong) ExplorationStackInteractiveTransitioning *interactiveTransitionPresent;

// Gesture
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeRecognizerDown;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeRecognizerUp;
@property (nonatomic) BOOL gesturesEnabled;

// CollectionViewLayout
@property (nonatomic, strong) ExplorationStackViewLayout *layout;
@property (nonatomic) NSInteger indexItem;
@property (nonatomic) NSIndexPath *currentDraggedCellPath;
@property (nonatomic) CGPoint pointCurrentCell;

@property (nonatomic) NSIndexPath *indexCell;
@property (nonatomic) BOOL fullScreen;
@property (nonatomic, strong) NSMutableArray *arrColor;

@end


@implementation ExplorationViewController

@synthesize gesturesEnabled = _gesturesEnabled;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initFakeData];
    [self initCollectionViewLayout];
    [self setGesturesEnabled:YES];
    [self initInteractiveTransition];
    
    self.transitioningDelegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initFakeData {
    _indexItem  = 0;
    _indexCell = [NSIndexPath indexPathForItem:_indexItem inSection:0];
    _fullScreen = NO;
    _arrColor = [[NSMutableArray alloc] init];
    [_arrColor addObject:[UIColor grayColor]];
    [_arrColor addObject:[UIColor blueColor]];
    [_arrColor addObject:[UIColor yellowColor]];
    [_arrColor addObject:[UIColor magentaColor]];
}

- (void)initCollectionViewLayout {
    _layout = [[ExplorationStackViewLayout alloc] init];
    self.collectionView.collectionViewLayout = _layout;
    [self.collectionView setScrollEnabled:NO];
    [self.collectionView reloadData];
}

- (void)initInteractiveTransition {
    _interactiveTransitionPresent = [[ExplorationStackInteractiveTransitioning alloc] init];
    _interactiveTransitionPresent.isPresent = YES;
    _interactiveTransitionPresent.interactionInProgress = NO;
    [_interactiveTransitionPresent attachToViewController:self withView:self.view presentViewController:nil];
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


#pragma mark - Handling the Swipe and PanGesture

- (void)setGesturesEnabled:(BOOL)gesturesEnabled {
    _gesturesEnabled = gesturesEnabled;
    if (_gesturesEnabled) {
        if (!_swipeRecognizerUp) {
            _swipeRecognizerUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRecognizer:)];
            _swipeRecognizerUp.direction = UISwipeGestureRecognizerDirectionUp;
            _swipeRecognizerUp.delegate = self;
            [self.collectionView addGestureRecognizer:_swipeRecognizerUp];
        }
        
        if (!_swipeRecognizerDown) {
            _swipeRecognizerDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRecognizer:)];
            _swipeRecognizerDown.direction = UISwipeGestureRecognizerDirectionDown;
            _swipeRecognizerDown.delegate = self;
            [self.collectionView addGestureRecognizer:_swipeRecognizerDown];
        }
        
        if (!_panGestureRecognizer) {
            _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureRecognizer:)];
            _panGestureRecognizer.delegate = self;
            [_panGestureRecognizer requireGestureRecognizerToFail:_swipeRecognizerUp];
            [_panGestureRecognizer requireGestureRecognizerToFail:_swipeRecognizerDown];
            [self.collectionView addGestureRecognizer:_panGestureRecognizer];
        }
        
    } else {
        
        [self.collectionView removeGestureRecognizer:_panGestureRecognizer];
        [self.collectionView removeGestureRecognizer:_swipeRecognizerUp];
        [self.collectionView removeGestureRecognizer:_swipeRecognizerDown];
        
        _panGestureRecognizer = nil;
        _swipeRecognizerUp = nil;
        _swipeRecognizerDown = nil;
    }
}

- (void)setIndexItem:(NSInteger)indexItem {
    if (_indexItem > indexItem) {
        _currentDraggedCellPath = [NSIndexPath indexPathForRow:indexItem inSection:0];
    } else {
        _currentDraggedCellPath = [NSIndexPath indexPathForRow:_indexItem inSection:0];
    }
    
    _indexItem = indexItem;
    _layout.indexItem = _indexItem;
    _indexCell = [NSIndexPath indexPathForRow:_indexItem inSection:0];
    
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:_currentDraggedCellPath];
    if (!cell) {
        return;
    } else {
        [self.collectionView bringSubviewToFront:cell];
        
        [self.collectionView performBatchUpdates:^{
            __weak typeof(&*self) self_weak_ = self;
            [self_weak_.collectionView.collectionViewLayout invalidateLayout];
        } completion:^(BOOL finished) {
            return;
        }];
    }
}

- (void)handleSwipeRecognizer:(UISwipeGestureRecognizer *)sender {
    switch (sender.direction) {
        case UISwipeGestureRecognizerDirectionUp:
        {
            if (sender.state == UIGestureRecognizerStateEnded) {
                
                [self selectedModeFullScreen:[NSIndexPath indexPathForItem:_indexItem inSection:0]];
            }
        }
            break;
        case UISwipeGestureRecognizerDirectionDown: {
            
        }
            break;
            
        default:
            break;
    }
    
}

- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)sender {
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            CGPoint pointGesture = [sender locationInView:self.collectionView];
            [self findDraggingCellByCoordinate:pointGesture];
        }
            break;
            
        case UIGestureRecognizerStateChanged: {
            CGPoint pointGesture = [sender translationInView:self.collectionView];
            [self updatePositionOfDraggingCell:pointGesture];
        }
            break;
            
        case UIGestureRecognizerStateEnded: {
            
            [self finishedDraggingCell:[self.collectionView cellForItemAtIndexPath:_currentDraggedCellPath]];
        }
            break;
            
        default:
            break;
    }
}

- (void)findDraggingCellByCoordinate:(CGPoint)touchCoordinate {
    NSIndexPath * indexPath = [self.collectionView indexPathForItemAtPoint:touchCoordinate];
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    
    if (cell) {
        if (indexPath.item >= _indexItem) {
            _currentDraggedCellPath = [NSIndexPath indexPathForRow:_indexItem inSection:0];
        } else {
            
        }
        _pointCurrentCell = cell.center;
        _currentDraggedCellPath = indexPath;
        [self.collectionView bringSubviewToFront:cell];
    }
}

- (void)updatePositionOfDraggingCell:(CGPoint)touchCoordinate {
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:_currentDraggedCellPath];
    
    CGFloat newCenterX = _pointCurrentCell.x + touchCoordinate.x;
    CGFloat newCenterY = _pointCurrentCell.y + touchCoordinate.y;
    
    if (cell) {
        cell.center = CGPointMake(newCenterX, newCenterY);
        cell.transform = CGAffineTransformRotate(CGAffineTransformIdentity,(CGFloat)[self getAngleOfRotation]);
        
        CGFloat deltaX = ABS(cell.center.x - _pointCurrentCell.x);
        BOOL isLeft = NO;
        BOOL isRight = NO;
        
        if (deltaX > minimumXPanDistanceToSwipe) {
            if ([self getAngleOfRotation] > 0) {
                isRight = YES;
            } else {
                isLeft = YES;
            }
        }
        [self updateDraggingLeft:isLeft Right:isRight];
    }
}

- (void)finishedDraggingCell:(UICollectionViewCell *)cell {
    
    CGFloat deltaX = ABS(cell.center.x - _pointCurrentCell.x);
    BOOL isLeft = NO;
    BOOL isRight = NO;
    
    if (deltaX < minimumXPanDistanceToSwipe) {
        
        if (cell) {
            
            [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                __weak typeof(&*self) self_weak_ = self;
                cell.center = self_weak_.layout.pointDefaultCell;
                cell.transform = CGAffineTransformIdentity;
            } completion:nil];
            
            [self updateDraggingLeft:isLeft Right:isRight];
        }
        
    } else {
        
        if (_currentDraggedCellPath.item == _indexItem) {
            [self setIndexItem:_indexItem +1];
        } else {
            [self setIndexItem:_indexItem - 1];
        }
        _pointCurrentCell = CGPointZero;
        _currentDraggedCellPath = nil;
        
        if ([self getAngleOfRotation] > 0) {
            isRight = YES;
        } else {
            isLeft = YES;
        }
        
        [self didFinishDraggingLeft:isLeft Right:isRight];
    
    }
}

- (double)getAngleOfRotation {
    double result = 0;
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:_currentDraggedCellPath];
    if (cell) {
        CGFloat pointYCollectionView = self.collectionView.frame.size.height + self.layout.itemSize.height;
        CGFloat angle = ((cell.center.x -  self.collectionView.bounds.size.width/2)/(pointYCollectionView - cell.center.y));
        result = atan(angle);
    }
    
    return result;
}


#pragma mark - UpdateButonLeftRight

- (void)didFinishDraggingLeft:(BOOL)isLeft Right:(BOOL)isRight {
    _btnLeft.transform = CGAffineTransformMakeScale(1,1);
    _btnRight.transform = CGAffineTransformMakeScale(1,1);
}

- (void)updateDraggingLeft:(BOOL)isLeft Right:(BOOL)isRight {
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

- (void)selectedModeFullScreen:(NSIndexPath *)indexPath {
    
    MangaInfoCollectionView *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:NSStringFromClass([MangaInfoCollectionView class])];
    
    _interactiveTransition = [[ExplorationStackInteractiveTransitioning alloc] init];
    [_interactiveTransition attachToViewController:self withView:vc.view presentViewController:vc];
    _interactiveTransitionPresent.isPresent = NO;
    vc.interactiveTransition = _interactiveTransition;
    vc.transitioningDelegate = self;
    vc.delegate = self;
    vc.numberOfRow = 5;
    [vc.collectionView setScrollEnabled:YES];
    
    [self presentViewController:vc animated:YES completion:nil];
}


#pragma mark - MangaInfoCollectionViewDelegate

- (void)mangaInfoCollectionView:(MangaInfoCollectionView *)vc didSmallScreen:(NSIndexPath*)indexPath {
    
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
    
    self.interactiveTransition.interactionInProgress = YES;

    return self.interactiveTransition;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    
    self.interactiveTransitionPresent.interactionInProgress = YES;
    
    return self.interactiveTransitionPresent;
}

- (CGRect)getFrameCellAtIndexPath:(NSIndexPath*)indexPath {
    UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath];
    
    return attributes.frame;
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
