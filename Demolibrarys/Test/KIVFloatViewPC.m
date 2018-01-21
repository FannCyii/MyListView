//
//  KIVFloatViewPC.m
//  Demolibrarys
//
//  Created by Fann on 20/01/2018.
//  Copyright © 2018 kivan. All rights reserved.
//

#import "KIVFloatViewPC.h"


@interface KIVFloatViewPC ()
@property (nonatomic, strong) UIView *dimmingView;
@property (nonatomic, strong)UITapGestureRecognizer *tapGesture;
@end

@implementation KIVFloatViewPC

- (void)addDimmingView
{
    self.dimmingView = [[UIView alloc] initWithFrame:self.containerView.bounds];
    
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [self.dimmingView addGestureRecognizer:_tapGesture];
    self.dimmingView.backgroundColor = [UIColor clearColor];
    [self.containerView addSubview:self.dimmingView];
}

- (void)presentationTransitionWillBegin
{
    [self addDimmingView];
    
    CGRect frame = self.presentingViewController.view.frame;
//    self.presentedView.frame = CGRectMake(0, frame.size.height, frame.size.width, frame.size.width);
    
    self.presentedView.frame = CGRectMake(frame.size.width - 110, 0, 100, 210);
    
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
//        self.presentedView.frame = CGRectMake(0, frame.size.height - 220, frame.size.width, 220);
        self.presentedView.frame = CGRectMake(frame.size.width - 110, 50, 100, 210);
        self.presentedView.alpha = 1;
        
        self.dimmingView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.1];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
}

- (void)dismissalTransitionWillBegin
{
    CGRect frame = self.presentedViewController.view.frame;
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.0;
        self.presentedView.frame = CGRectMake(frame.origin.x + frame.size.width, frame.origin.y, 0, 0);
        self.presentedView.alpha = 0;
    } completion:nil];
}

- (void)tapGestureAction:(UITapGestureRecognizer *)tap
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}
@end

