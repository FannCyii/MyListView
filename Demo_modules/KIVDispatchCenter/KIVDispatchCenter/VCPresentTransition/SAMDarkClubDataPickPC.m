//
//  SAMDarkClubDataPickPC.m
//  CheckOrder
//
//  Created by kivan on 14/11/2017.
//  Copyright © 2017 CheckOrder. All rights reserved.
//

#import "SAMDarkClubDataPickPC.h"

@interface SAMDarkClubDataPickPC ()
@property (nonatomic, strong) UIView *dimmingView;
@property (nonatomic, strong)UITapGestureRecognizer *tapGesture;
@end

@implementation SAMDarkClubDataPickPC
- (void)presentationTransitionWillBegin
{
    self.dimmingView = [[UIView alloc] initWithFrame:self.containerView.bounds];
    
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [self.dimmingView addGestureRecognizer:_tapGesture];
    self.dimmingView.backgroundColor = [UIColor clearColor];
    [self.containerView addSubview:self.dimmingView];
    
    CGRect frame = self.presentingViewController.view.frame;
    self.presentedView.frame = CGRectMake(0, frame.size.height, frame.size.width, 220);
    
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.presentedView.frame = CGRectMake(0, frame.size.height - 220, frame.size.width, 220);
        self.dimmingView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
}

- (void)dismissalTransitionWillBegin
{
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.0;
    } completion:nil];
}

- (void)tapGestureAction:(UITapGestureRecognizer *)tap
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
