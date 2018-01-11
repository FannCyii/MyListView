//
//  UserInfoPC.m
//  Demolibrarys
//
//  Created by Fann on 11/01/2018.
//  Copyright © 2018 kivan. All rights reserved.
//

#import "UserInfoPC.h"

@interface UserInfoPC()
@property (nonatomic, strong) UIView *dimmingView;
@property (nonatomic, strong)UITapGestureRecognizer *tapGesture;
@end

@implementation UserInfoPC
- (void)presentationTransitionWillBegin
{
    self.dimmingView = [[UIView alloc] initWithFrame:self.containerView.bounds];
    
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [self.dimmingView addGestureRecognizer:_tapGesture];
    self.dimmingView.backgroundColor = [UIColor clearColor];
    [self.containerView addSubview:self.dimmingView];
    
    CGRect frame = self.presentingViewController.view.frame;
    self.presentedView.frame = CGRectMake(0, 0, 0, frame.size.height);
    
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.presentedView.frame = CGRectMake(0, 0, frame.size.width*2/3, frame.size.height);
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
