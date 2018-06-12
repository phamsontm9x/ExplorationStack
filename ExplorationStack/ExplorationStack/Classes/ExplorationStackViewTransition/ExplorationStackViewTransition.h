//
//  ExplorationStackViewTransition.h
//  ExplorationStack
//
//  Created by Son Pham on 6/12/18.
//  Copyright © 2018 Son Pham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>



@interface ExplorationStackViewTransition : NSObject<UIViewControllerAnimatedTransitioning, UINavigationControllerDelegate>

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView;


@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) BOOL reverse;
@property (nonatomic) CGRect fromViewDefault;
@property (nonatomic) UIImageView *snapShot;
@property (nonatomic, assign) UIViewKeyframeAnimationOptions transitionAnimationOption;

@end
