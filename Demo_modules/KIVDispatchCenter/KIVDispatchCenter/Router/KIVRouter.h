//
//  KIVRouter.h
//  KIVDispatchCenter
//
//  Created by Fann on 02/01/2018.
//  Copyright © 2018 Fann. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^KIVRouteCompleteBlock)(UIViewController *vc, NSError *error);
typedef void (^KIVRouteHandleBlock)(UIViewController *vc, NSError *error);

@interface KIVRouter : NSObject

+ (instancetype)sharedInstance;
- (void)registeRootVC:(UIViewController *)rootVc;
- (NSString *)routeClassNameForkey:(NSString *)key;



#pragma mark - 跳转
/**
 跳转到指定 “模块”
 
 @param key 模块名称
 @param aParams 传入参数
 @param routeCompleteBlock 跳转后回调
 */
- (void)routeToModulesOfKey:(NSString *)key withParams:(NSDictionary *)aParams routeCompleteBlock:(KIVRouteCompleteBlock)routeCompleteBlock;
- (void)routeToModulesOfKey:(NSString *)key withRouteCompleteBlock:(KIVRouteCompleteBlock)routeCompleteBlock;
- (void)routeToModulesOfKey:(NSString *)key withParams:(NSDictionary *)aParams;
- (void)routeToModulesOfKey:(NSString *)key;

/*
 跳转过过程
 
 全局router跳转前后处理,如跳转前可以做登录判断等操作
 */
- (void)beforeRouterWithHandle:(KIVRouteHandleBlock)handleBlock;
- (void)afterRouterWithHandle:(KIVRouteHandleBlock)handleBlock;

@end

@interface UIViewController(KIVRouter)
@property (nonatomic, strong) NSDictionary *routerParamsDir;
@property (nonatomic, strong) KIVRouteHandleBlock routerhandleBlock;
@end

