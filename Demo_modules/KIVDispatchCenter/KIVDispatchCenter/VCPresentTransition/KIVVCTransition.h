//
//  KIVVCTransition.h
//  CheckOrder
//
//  Created by kivan on 27/09/2017.
//  Copyright © 2017 CheckOrder. All rights reserved.
//

#import <UIKit/UIkit.h>

@interface KIVVCTransition : NSObject <UIViewControllerTransitioningDelegate>

/**
 使用PresentationController

 @param pcClassName 自定义presenttinController类名
 @return 返回delegate
 */
- (instancetype)initSamVCTransitionWithPresentationControllerClassName:(NSString *)pcClassName;

/**
 使用自定义动画Animator

 @param animatorClassName 自定义动画类名
 @return 返回delegate
 */
- (instancetype)initSamVCTransitionWithPresentationAnimatorName:(NSString *)animatorClassName;


/**
 使用自定义动画Animator  和 PresentationController

 @param animatorClassName 自定义动画类名
 @param pcClassName 自定义presenttinController类名
 @return 返回delegate
 */
- (instancetype)initSamVCTransitionWithPresentationAnimatorClassName:(NSString *)animatorClassName presentationControllerClassName:(NSString *)pcClassName;

@end
