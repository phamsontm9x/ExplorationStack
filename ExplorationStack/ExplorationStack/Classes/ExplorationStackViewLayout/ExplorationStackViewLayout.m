//
//  ExplorationStackViewLayout.m
//  ExplorationStack
//
//  Created by Son Pham on 6/8/18.
//  Copyright © 2018 Son Pham. All rights reserved.
//

#import "ExplorationStackViewLayout.h"



@interface ExplorationStackViewLayout() <UIGestureRecognizerDelegate>

@property (nonatomic) NSInteger numberRowOfSection;
@property (nonatomic) CGPoint pointCurrentCell;
@property (nonatomic) NSIndexPath *currentDraggedCellPath;
@property (nonatomic) NSInteger centralCardYPosition;
@property (nonatomic) CGFloat verticalOffsetBetweenViewStack;

@end



@implementation ExplorationStackViewLayout

__const NSInteger maxZIndexTopStack = 1000;
__const NSInteger dragingCellZIndex = 10000;
__const CGFloat kHeight = 0.6;
__const CGFloat kWidth = 0.6;



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
}


#pragma mark - Override

- (void)prepareLayout {
    _centralCardYPosition = self.collectionView.bounds.size.height * (1 - kHeight) / 2 ;
    _itemSize =  CGSizeMake(self.collectionView.bounds.size.width *kWidth, self.collectionView.bounds.size.height *kHeight);
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


@end










