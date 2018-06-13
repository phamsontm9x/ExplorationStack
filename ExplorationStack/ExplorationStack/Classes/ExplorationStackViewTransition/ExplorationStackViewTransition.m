//
//  ExplorationStackViewTransition.m
//  ExplorationStack
//
//  Created by Son Pham on 6/12/18.
//  Copyright © 2018 Son Pham. All rights reserved.
//

#import "ExplorationStackViewTransition.h"



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
    
    UIView *endingView = [[UIView alloc] initWithFrame:(_reverse) ? _fromViewDefault : toView.frame];
    
    
    CGFloat endingViewInitialTransform = CGRectGetHeight(fromView.frame) / CGRectGetHeight(endingView.frame);
    CGPoint translatedStartingViewCenter = fromView.center;
    toView.center = translatedStartingViewCenter;
    
    toView.alpha = (_reverse) ? 1 : 0;
    fromView.alpha = 1.0;
    
    CGFloat startingViewFinalTransform = 1.0 / endingViewInitialTransform;
    CGPoint translatedEndingViewFinalCenter = toView.center;
    
    // animate
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         toView.center = translatedEndingViewFinalCenter;
                         fromView.transform = CGAffineTransformScale(fromView.transform, startingViewFinalTransform, startingViewFinalTransform);
                         fromView.center = translatedEndingViewFinalCenter;
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            
        } else {
            toView.alpha = 1.0;
            fromView.alpha = 0.0;
            [fromView removeFromSuperview];
        }
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
