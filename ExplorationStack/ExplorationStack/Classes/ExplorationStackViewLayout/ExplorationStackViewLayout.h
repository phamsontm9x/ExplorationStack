//
//  ExplorationStackViewLayout.h
//  ExplorationStack
//
//  Created by Son Pham on 6/8/18.
//  Copyright © 2018 Son Pham. All rights reserved.
//

#import <UIKit/UIKit.h>



@class ExplorationStackViewLayout;


@protocol ExplorationStackViewLayoutDelegate <UICollectionViewDelegate>
- (void)explorationStackViewLayout:(UICollectionViewLayout *)collectionViewLayout didFinishDraggingLeft:(BOOL)isLeft Right:(BOOL)isRight;
- (void)explorationStackViewLayout:(UICollectionViewLayout *)collectionViewLayout updateDraggingLeft:(BOOL)isLeft Right:(BOOL)isRight;
- (void)explorationStackViewLayout:(UICollectionViewLayout *)collectionViewLayout cellWillFullScreen:(NSIndexPath*)indexPath;
//- (void)explorationStackViewLayout:(UICollectionViewLayout *)collectionViewLayout cellDidSmallScreen:(NSIndexPath*)indexPath;

@end



@interface ExplorationStackViewLayout : UICollectionViewLayout

@property (nonatomic, weak) id<ExplorationStackViewLayoutDelegate> delegateDrag;

// The maximum number of cards displayed on the top stack. This value includes the currently visible view.
@property (nonatomic) NSInteger topStackMaximumSize;

// The maximum number of cards displayed on the bottom stack.
@property (nonatomic) NSInteger bottomStackMaximumSize;

/// The visible height of the card of the bottom stack.
@property (nonatomic) CGFloat bottomStackCardHeight;

// The inset or outset margins for the rectangle around the card.
@property (nonatomic) UIEdgeInsets itemInsets;

// The size of a view in the stack layout.
@property (nonatomic) CGSize itemSize;

// A Boolean value indicating whether the pan and swipe gestures on cards are enabled.
@property (nonatomic) BOOL gesturesEnabled;

- (void)loadSmallScreen;
- (void)loadFullScreen;

@end
