//
//  AnimatorPopping.m
//  CheckOrder
//
//  Created by kivan on 14/11/2017.
//  Copyright © 2017 CheckOrder. All rights reserved.
//

#import "AnimatorPopping.h"

@implementation AnimatorPopping
- (void)animateInTransitioning:(id <UIViewControllerContextTransitioning>)transitionContext
{
    // 1. Get controllers from transition context
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    // 2. Set init frame for toVC
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = screenBounds;//CGRectOffset(finalFrame, 0, screenBounds.size.height);
    toVC.view.alpha = 0;
    // 3. Add toVC's view to containerView
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];
    
    // 4. Do animate now
    NSTimeInterval duration = [self animateDuration:transitionContext];
    
    [UIView animateWithDuration:duration
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionTransitionFlipFromBottom
                     animations:^{
//                         toVC.view.frame = finalFrame;
                         toVC.view.alpha = 1;
                     } completion:^(BOOL finished) {
                         // 5. Tell context that we completed.
                         //[screenSnapShotView removeFromSuperview];
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
    
}
- (void)animateOutTransitioning:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [[transitionContext containerView] addSubview:toView];
    CGRect orignFrame = fromView.frame;
    toView.frame = orignFrame;
    [fromView.superview bringSubviewToFront:fromView];
    NSTimeInterval duration = 0.2f;
    [UIView animateWithDuration:duration animations:^{
//        fromView.frame = CGRectMake(orignFrame.origin.x, orignFrame.origin.y + orignFrame.size.height, orignFrame.size.width, orignFrame.size.height);
        fromView.alpha = 0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (NSTimeInterval)animateDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}
@end
