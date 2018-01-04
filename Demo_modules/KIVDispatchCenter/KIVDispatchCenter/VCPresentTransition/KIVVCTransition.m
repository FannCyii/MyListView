//
//  KIVVCTransition.m
//  CheckOrder
//
//  Created by kivan on 27/09/2017.
//  Copyright © 2017 CheckOrder. All rights reserved.
//

#import "KIVVCTransition.h"
#import "KIVAnimator.h"


@interface KIVVCTransition ()
@property (nonatomic, strong) NSString *animatorClassName;
@property (nonatomic, strong) NSString *pcClassName;

@end

@implementation KIVVCTransition

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [KIVAnimator animatorWith:self.animatorClassName withType:KIVAnimatorIn];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [KIVAnimator animatorWith:self.animatorClassName withType:KIVAnimatorOut];
}

#pragma mark - init
- (instancetype)initSamVCTransitionWithPresentationControllerClassName:(NSString *)pcClassName
{
    return [self initSamVCTransitionWithPresentationAnimatorClassName:nil presentationControllerClassName:pcClassName];
}

- (instancetype)initSamVCTransitionWithPresentationAnimatorName:(NSString *)animatorClassName
{
    return [self initSamVCTransitionWithPresentationAnimatorClassName:animatorClassName presentationControllerClassName:nil];
}

- (instancetype)initSamVCTransitionWithPresentationAnimatorClassName:(NSString *)animatorClassName presentationControllerClassName:(NSString *)pcClassName
{
    if ([self init]) {
        if (NSClassFromString(animatorClassName)) {
            self.animatorClassName = animatorClassName;
        }
        if (NSClassFromString(pcClassName)) {
            self.pcClassName = pcClassName;
        }
    }
    return self;
}


- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    id presentObjct;
    if ([NSClassFromString(self.pcClassName) instancesRespondToSelector:@selector(initWithPresentedViewController:presentingViewController:)]) {
        presentObjct = [[NSClassFromString(self.pcClassName) alloc]  initWithPresentedViewController:presented presentingViewController:presenting];
    }
    return presentObjct;
}


@end
