//
//  ExplorationStackViewLayout.m
//  ExplorationStack
//
//  Created by Son Pham on 6/8/18.
//  Copyright © 2018 Son Pham. All rights reserved.
//

#import "ExplorationStackViewLayout.h"



@interface ExplorationStackViewLayout() <UIGestureRecognizerDelegate>

@property (nonatomic) NSInteger indexItem;
@property (nonatomic) NSInteger numberRowOfSection;
@property (nonatomic) CGPoint pointCurrentCell;
@property (nonatomic) CGPoint pointDefaultCell;
@property (nonatomic) NSIndexPath *currentDraggedCellPath;
//@property (nonatomic) CGFloat paddingWidth;
//@property (nonatomic) CGFloat kHeight;
@property (nonatomic) NSInteger centralCardYPosition;
@property (nonatomic) CGFloat verticalOffsetBetweenViewStack;
@property (nonatomic) BOOL isFullScreen;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeRecognizerDown;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeRecognizerUp;

@end



@implementation ExplorationStackViewLayout

__const NSInteger maxZIndexTopStack = 1000;
__const NSInteger dragingCellZIndex = 10000;
__const CGFloat kHeight = 0.6;
__const CGFloat paddingWidth = 80;

#warning check value

__const NSInteger minimumXPanDistanceToSwipe = 100;


@synthesize gesturesEnabled = _gesturesEnabled;


#pragma mark - Inits

- (id)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {

    _verticalOffsetBetweenViewStack = 10;
    _centralCardYPosition = 150;
    _isFullScreen = NO;
    //_itemSize = CGSizeMake(280, 380);
    _gesturesEnabled = YES;
}


#pragma mark - Override

- (void)prepareLayout {
//    [self configGesture];
    _itemSize =  CGSizeMake(self.collectionView.bounds.size.width - paddingWidth *2, self.collectionView.bounds.size.height *kHeight);
    _topStackMaximumSize = 3;
    _numberRowOfSection = [self.collectionView numberOfItemsInSection:0];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *attributes = [NSMutableArray new];
    
    NSInteger topStackCount = MIN(_numberRowOfSection - (_indexItem + 1), _topStackMaximumSize - 1);
    NSInteger bottomStackCount = MIN(_indexItem, _bottomStackMaximumSize);
    
    NSInteger start = _indexItem - bottomStackCount;
    NSInteger end = (_indexItem + 1) + topStackCount;
    
    for (;start < end; start++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:start inSection:0];
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [attributes addObject:attribute];
    }
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    if (indexPath.item >= _indexItem) {
        attribute = [self getLayoutAttributesForStackItemTopWithInitialAttributes:attribute];
    } else {
        attribute = [self getLayoutAttributesForStackItemBotWithInitialAttributes:attribute];
    }
    
    if (indexPath.item == _currentDraggedCellPath.item) {
        attribute.zIndex = dragingCellZIndex;
    } else {
        attribute.zIndex = (indexPath.item >= _indexItem) ? (maxZIndexTopStack - indexPath.item) : (maxZIndexTopStack + indexPath.item);
    }

    return attribute;
}

- (CGSize)collectionViewContentSize {
    return self.collectionView.bounds.size;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return !(CGSizeEqualToSize(newBounds.size, self.collectionView.frame.size));
}

- (UICollectionViewLayoutAttributes *)getLayoutAttributesForStackItemTopWithInitialAttributes:(UICollectionViewLayoutAttributes *)attribute {
    
    CGFloat minYPosition = _centralCardYPosition + _verticalOffsetBetweenViewStack*(_topStackMaximumSize - 1);
    CGFloat yPosition = _centralCardYPosition + _verticalOffsetBetweenViewStack*(attribute.indexPath.row - _indexItem);
    yPosition = MIN(yPosition,minYPosition);
    
    if (attribute.indexPath.item == _numberRowOfSection - 1) {
        //New view has to be displayed if there are no topStackMaximumSize views in the top stack
        if ((attribute.indexPath.item >= _indexItem) && (attribute.indexPath.item < _indexItem + _topStackMaximumSize)) {
            yPosition = _centralCardYPosition + _verticalOffsetBetweenViewStack*(attribute.indexPath.row - _indexItem);
        } else {
            [attribute setHidden:YES];
            yPosition = _centralCardYPosition;
        }
    }
    
    CGFloat xPosition = (self.collectionView.frame.size.width - _itemSize.width)/2;
    CGRect itemFrame = CGRectMake(xPosition, yPosition, _itemSize.width, _itemSize.height);
    attribute.frame = itemFrame;
    
    if (attribute.indexPath.item == _indexItem && _isFullScreen) {
        attribute.frame = self.collectionView.bounds;
    }
    
    if (attribute.indexPath.item == _indexItem) {
        _pointDefaultCell = attribute.center;
    }
    
    return attribute;
}

- (UICollectionViewLayoutAttributes *)getLayoutAttributesForStackItemBotWithInitialAttributes:(UICollectionViewLayoutAttributes *)attribute {
    
    
    CGFloat yPosition = self.collectionView.frame.size.height;
    CGFloat xPosition = (self.collectionView.frame.size.width - _itemSize.width)/2;

    CGRect itemFrame = CGRectMake(xPosition, yPosition, _itemSize.width, _itemSize.height);
    attribute.frame = itemFrame;
    
//    attribute.hidden = YES;
    
    return attribute;
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
    
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:_currentDraggedCellPath];
    if (!cell) {
        return;
    } else {
        [self.collectionView bringSubviewToFront:cell];
        
        [self.collectionView performBatchUpdates:^{
            __weak typeof(&*self) self_weak_ = self;
            [self_weak_ invalidateLayout];
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
                [self loadFullScreen];
            }
        }
            break;
        case UISwipeGestureRecognizerDirectionDown:
        {
            [self loadSmallScreen];
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
        
        __strong typeof(_delegateDrag) delegate = _delegateDrag;
        if (delegate && [delegate respondsToSelector:@selector(explorationStackViewLayout:updateDraggingLeft:Right:)]) {
            [delegate explorationStackViewLayout:self updateDraggingLeft:isLeft Right:isRight];
        }
    }
}

- (void)finishedDraggingCell:(UICollectionViewCell *)cell {
    
    CGFloat deltaX = ABS(cell.center.x - _pointCurrentCell.x);
    BOOL isLeft = NO;
    BOOL isRight = NO;
    __strong typeof(_delegateDrag) delegate = _delegateDrag;
    
    if (deltaX < minimumXPanDistanceToSwipe) {
        
        if (cell) {
    
            [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                __weak typeof(&*self) self_weak_ = self;
                cell.center = self_weak_.pointDefaultCell;
                cell.transform = CGAffineTransformIdentity;
            } completion:nil];
            
            if (delegate && [delegate respondsToSelector:@selector(explorationStackViewLayout:updateDraggingLeft:Right:)]) {
                [delegate explorationStackViewLayout:self updateDraggingLeft:isLeft Right:isRight];
            }
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
        
        if (delegate && [delegate respondsToSelector:@selector(explorationStackViewLayout:didFinishDraggingLeft:Right:)]) {
            [delegate explorationStackViewLayout:self didFinishDraggingLeft:isLeft Right:isRight];
        }
    }
}

- (double)getAngleOfRotation {
    double result = 0;
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:_currentDraggedCellPath];
    if (cell) {
        CGFloat pointYCollectionView = self.collectionView.frame.size.height + _itemSize.height;
        CGFloat angle = ((cell.center.x -  self.collectionView.bounds.size.width/2)/(pointYCollectionView - cell.center.y));
        result = atan(angle);
    }
    
    return result;
}


#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {

    BOOL result = YES;
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint velocity = [gestureRecognizer velocityInView:self.collectionView];
        result = abs((int)(velocity.y) < 250);
    }

    return result;
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - Helpers

- (void)loadFullScreen {
    if (!_isFullScreen) {
        _isFullScreen = YES;
        __strong typeof(_delegateDrag) delegate = _delegateDrag;
        if (delegate && [delegate respondsToSelector:@selector(explorationStackViewLayout:cellWillFullScreen:)]) {
            [delegate explorationStackViewLayout:self cellWillFullScreen:[NSIndexPath indexPathForItem:_indexItem inSection:0]];
        }
        [self reloadLayoutCollectionView];
    }
}

- (void)loadSmallScreen {
    if (_isFullScreen) {
        _isFullScreen = NO;
        [self reloadLayoutCollectionView];
        __strong typeof(_delegateDrag) delegate = _delegateDrag;
        if (delegate && [delegate respondsToSelector:@selector(explorationStackViewLayout:cellDidSmallScreen:)]) {
            [delegate explorationStackViewLayout:self cellDidSmallScreen:[NSIndexPath indexPathForItem:_indexItem inSection:0]];
        }
    }
}

- (void)reloadLayoutCollectionView {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.3];
    
    [self.collectionView performBatchUpdates:^{
        __weak typeof(&*self) self_weak_ = self;
        [self_weak_ invalidateLayout];
    } completion:^(BOOL finished) {
        
    }];
    
    [CATransaction commit];
    [UIView commitAnimations];
}

@end










