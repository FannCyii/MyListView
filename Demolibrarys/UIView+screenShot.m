//
//  UIView+screenShot.m
//  TransitionAnimation_B
//
//  Created by chengqifan on 05/05/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "UIView+screenShot.h"

@implementation UIView (screenShot)

+ (UIImage *)screenShot
{
    UIWindow *screenWindow = [UIApplication sharedApplication].keyWindow;
    UIGraphicsBeginImageContext(screenWindow.frame.size);
    [[screenWindow.rootViewController.view layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* viewImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

+ (UIImage *)screenShotWithRect:(CGRect)rect
{
    //需要截取某区域的画面，则运行如下代码
    CGImageRef imageRef = [self screenShot].CGImage;
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *rectImage = [[UIImage alloc] initWithCGImage:imageRefRect];//生成截取图片
    return rectImage;
}


+ (UIImage *)viewShotWithView:(UIView *)view
{
    //UIWindow *screenWindow = [UIApplication sharedApplication].keyWindow;
    UIGraphicsBeginImageContext(view.frame.size);
    [[view layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* viewImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

- (UIImage *)viewShot
{
    //UIWindow *screenWindow = [UIApplication sharedApplication].keyWindow;
    UIGraphicsBeginImageContext(self.frame.size);
    [[self layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* viewImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

- (UIImage *)viewShotWithRect:(CGRect)rect
{
    CGImageRef imageRef = [self viewShot].CGImage;
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *rectImage = [[UIImage alloc] initWithCGImage:imageRefRect];//生成截取图片
    return rectImage;
}





@end
