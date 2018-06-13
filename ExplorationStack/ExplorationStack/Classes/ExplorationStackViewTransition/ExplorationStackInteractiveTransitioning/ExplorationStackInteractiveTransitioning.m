//
//  ExplorationStackInteractiveTransitioning.m
//  ExplorationStack
//
//  Created by Son Pham on 6/13/18.
//  Copyright © 2018 Son Pham. All rights reserved.
//

#import "ExplorationStackInteractiveTransitioning.h"
#import <objc/runtime.h>


const NSString *kCEHorizontalSwipeGestureKey = @"kCEHorizontalSwipeGestureKey";

@implementation ExplorationStackInteractiveTransitioning {
    BOOL _shouldCompleteTransition;
    UIViewController *_viewController;
}

- (void)wireToViewController:(UIViewController *)viewController {
    self.popOnTopToBot = YES;
    _viewController = viewController;
    [self prepareGestureRecognizerInView:viewController.view];
}

- (void)prepareGestureRecognizerInView:(UIView*)view {
    
    UIPanGestureRecognizer *gesture = objc_getAssociatedObject(view, (__bridge const void *)(kCEHorizontalSwipeGestureKey));
    
    if (gesture) {
        [view removeGestureRecognizer:gesture];
    }
    
    
    gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:gesture];
    
    objc_setAssociatedObject(view, (__bridge const void *)(kCEHorizontalSwipeGestureKey), gesture,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (CGFloat)completionSpeed
{
    return 1 - self.percentComplete;
}

- (void)handleGesture:(UIPanGestureRecognizer*)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    CGPoint vel = [gestureRecognizer velocityInView:gestureRecognizer.view];
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            BOOL topToBottSwipe = vel.y < 0;
            if (topToBottSwipe) {
                // for dismiss, fire regardless of the translation direction
                self.interactionInProgress = YES;
                [_viewController dismissViewControllerAnimated:YES completion:nil];
            }
        }
            break;
        case UIGestureRecognizerStateChanged: {
            if (self.interactionInProgress) {
                // compute the current position
                CGFloat fraction = fabs(translation.y / 200.0);
                fraction = fminf(fmaxf(fraction, 0.0), 1.0);
                _shouldCompleteTransition = (fraction > 0.5);
                
                // if an interactive transitions is 100% completed via the user interaction, for some reason
                // the animation completion block is not called, and hence the transition is not completed.
                // This glorious hack makes sure that this doesn't happen.
                // see: https://github.com/ColinEberhardt/VCTransitionsLibrary/issues/4
                if (fraction >= 1.0)
                    fraction = 0.99;
                
                [self updateInteractiveTransition:fraction];
            }
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            if (self.interactionInProgress) {
                self.interactionInProgress = NO;
                if (!_shouldCompleteTransition || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
                    [self cancelInteractiveTransition];
                }
                else {
                    [self finishInteractiveTransition];
                }
            }
            break;
        default:
            break;
    }
}

@end
