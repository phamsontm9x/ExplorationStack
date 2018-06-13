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

@property (nonatomic) BOOL popOnTopToBot;
@property (nonatomic, assign) BOOL interactionInProgress;

- (void)wireToViewController:(UIViewController*)viewController;
@end
