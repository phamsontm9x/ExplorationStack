//
//  ExplorationStackInteractiveTransitioning.m
//  ExplorationStack
//
//  Created by Son Pham on 6/13/18.
//  Copyright © 2018 Son Pham. All rights reserved.
//

#import "ExplorationStackInteractiveTransitioning.h"
#import <objc/runtime.h>



@interface ExplorationStackInteractiveTransitioning () <UIGestureRecognizerDelegate>

@end


@implementation ExplorationStackInteractiveTransitioning {
    BOOL _shouldCompleteTransition;
    UIViewController *_viewController;
}

- (void)attachToViewController:(UIViewController *)viewController withView:(UIView *)view presentViewController:(UICollectionViewController *)presentViewController {
    self.viewController = viewController;
    self.presentViewController = presentViewController;
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    self.panGesture.delegate = self;
    
    if (_isPresent) {
        [view addGestureRecognizer:self.panGesture];
    } else {
        [self.presentViewController.collectionView addGestureRecognizer:self.panGesture];
    }
    
}

- (void)setInteractionInProgress:(BOOL)interactionInProgress {
    _interactionInProgress = interactionInProgress;
}

- (CGFloat)completionSpeed {
    return 1 - self.percentComplete;
}

- (void)handleGesture:(UIPanGestureRecognizer*)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    
    if (_interactionInProgress) {
        
        switch (gestureRecognizer.state) {
                
            case UIGestureRecognizerStateBegan: {
                
                if (_isPresent) {
                    
                } else {
                    [_presentViewController dismissViewControllerAnimated:YES completion:nil];
                    [_presentViewController.collectionView.panGestureRecognizer setEnabled:NO];
                }
                
            }
                break;
                
            case UIGestureRecognizerStateChanged: {
                if (self.interactionInProgress) {
                   
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
                    if (_isPresent) {
                        
                    } else {
                        [_presentViewController.collectionView.panGestureRecognizer setEnabled:YES];
                    }
                    
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
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {

    return YES;
}

@end
