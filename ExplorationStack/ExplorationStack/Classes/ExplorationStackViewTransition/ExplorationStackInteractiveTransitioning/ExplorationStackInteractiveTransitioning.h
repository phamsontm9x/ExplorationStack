//
//  ExplorationStackInteractiveTransitioning.h
//  ExplorationStack
//
//  Created by Son Pham on 6/13/18.
//  Copyright © 2018 Son Pham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

@interface ExplorationStackInteractiveTransitioning : UIPercentDrivenInteractiveTransition

@property (nonatomic) UIViewController *viewController;
@property (nonatomic) UICollectionViewController *presentViewController;
@property (nonatomic) UIPanGestureRecognizer *panGesture;
@property (nonatomic) UIPanGestureRecognizer *panGesturePresent;
@property (nonatomic) BOOL interactionInProgress;
@property (nonatomic) BOOL isPresent;

- (void)attachToViewController:(UIViewController *)viewController withView:(UIView *)view presentViewController:(UICollectionViewController *)presentViewController;
- (void)handleGesture:(UIPanGestureRecognizer*)gestureRecognizer;

@end
