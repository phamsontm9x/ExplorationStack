//
//  ExplorationStackViewTransition.m
//  ExplorationStack
//
//  Created by Son Pham on 6/12/18.
//  Copyright © 2018 Son Pham. All rights reserved.
//

#import "ExplorationStackViewTransition.h"
#import "CollectionViewController.h"



@interface ExplorationStackViewTransition ()

@end



@implementation ExplorationStackViewTransition

- (id)init {
    if (self = [super init]) {
        self.duration = 0.3f;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController * fromVC = (id)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toVC.view;
    UIView *fromView = (_reverse) ? fromVC.view : (UIView*)self.snapShot;
    [self animateTransition:transitionContext fromVC:fromVC toVC:toVC fromView:fromView toView:toView];
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {
    
    UIView* containerView = [transitionContext containerView];
    toView.frame = [transitionContext finalFrameForViewController:toVC];
    [containerView addSubview:toView];
    [containerView addSubview:fromView];
    if (_reverse) {
        
    } else {
        [containerView sendSubviewToBack:toView];
    }
    
    
    // animate
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    
    [UIView animateWithDuration:duration animations:^{
        __weak typeof(&*self) self_weak_ = self;
        if (self_weak_.reverse) {
            [fromView setFrame:self_weak_.fromViewDefault];
        } else {
            [fromView setFrame:toView.frame];
        }
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            
        } else {
            // reset from- view to its original state
            [fromView removeFromSuperview];
        }
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
