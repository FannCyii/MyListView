//
//  UIView+screenShot.h
//  TransitionAnimation_B
//
//  Created by chengqifan on 05/05/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (screenShot)

//屏幕截屏
+ (UIImage *)screenShot;
+ (UIImage *)screenShotWithRect:(CGRect)rect;

//视图截屏
- (UIImage *)viewShot;
- (UIImage *)viewShotWithRect:(CGRect)rect;



@end
