//
//  KIVTogetherTouchRecogizer.m
//  Demolibrarys
//
//  Created by kivan on 24/11/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "KIVTogetherTouchRecogizer.h"
#import "UIView+screenShot.h"

@interface KIVTogetherTouchRecogizer ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIPanGestureRecognizer *panGesturer;
@property (nonatomic, assign) CGRect orignFrame;
@property (nonatomic, assign) CGRect finalFrame;

@property (nonatomic, strong) UIImageView *shotImageView;
@end

@implementation KIVTogetherTouchRecogizer

- (instancetype)init
{
    self = [super init];
    if(self){
        self.panGesturer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGeuturerAction:)];
        self.panGesturer.delegate = self;
    }
    return self;
}


- (void)registerTouchView:(UIView *)touchView
{
//    self.shotImageView = [[UIImageView alloc] initWithImage:[touchView viewShot]];
//    self.shotImageView.frame = touchView.frame;
//    self.shotImageView.userInteractionEnabled = YES;
//    [[self keyWindowView] addSubview:self.shotImageView];
//    [[self keyWindowView] bringSubviewToFront:self.shotImageView];
//    [self.shotImageView addGestureRecognizer:self.panGesturer];
    
    [touchView addGestureRecognizer:self.panGesturer];
}

- (void)panGeuturerAction:(UIPanGestureRecognizer *)gesture
{
    UIView *panView = gesture.view;
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.orignFrame = panView.frame;
    }else if (gesture.state == UIGestureRecognizerStateChanged){
        CGPoint po = [gesture translationInView:[self keyWindowView]];
        //注意这里的translation指的都是偏移量，而不是坐标
        //返回移动中两点之间的偏移量，相对于上一点的坐标
        CGPoint p1 = [gesture translationInView:[self keyWindowView]];
        panView.center = CGPointMake(panView.center.x + po.x, panView.center.y + po.y);
        //设置手势的translation， 将相对于inView的坐标系中的偏移 设置为给定的偏移量
        [gesture setTranslation:CGPointMake(0, 0) inView:panView];
        //返回手势水平和垂直的速度，每秒,先对坐标系为InView
        //CGPoint veloci = [gesture velocityInView:self.view];
    }else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateEnded){
        self.finalFrame = panView.frame;
        
        if([self.delegate respondsToSelector:@selector(endGoBackWithTogetherTouch:)]){
            CGFloat duration = [self.delegate endGoBackWithTogetherTouch:self];
            if(duration > 0.01){
                [UIView animateWithDuration:duration animations:^{
                    panView.frame = self.orignFrame;
                }];
            }
        }
        
        if([self.delegate respondsToSelector:@selector(endWithTogetherTouch:targetView:)]){
            [self.delegate endWithTogetherTouch:self targetView:panView];
        }
    }
}

- (UIView *)keyWindowView
{
    return [UIApplication sharedApplication].keyWindow;
}


@end
