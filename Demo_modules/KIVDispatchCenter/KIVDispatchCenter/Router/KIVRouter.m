//
//  KIVRouter.m
//  KIVDispatchCenter
//
//  Created by Fann on 02/01/2018.
//  Copyright © 2018 Fann. All rights reserved.
//

#import "KIVRouter.h"
#import <objc/runtime.h>

#import "KIVVCTransition.h"

@interface KIVRouter()

@property (nonatomic, strong) NSDictionary *routerKeyMapList;
@property (nonatomic, strong) UIViewController *rootVC;

@property (nonatomic, copy) KIVRouteHandleBlock beforeHandle;
@property (nonatomic, copy) KIVRouteHandleBlock afterHandle;

@property (nonatomic, strong) KIVVCTransition *transition;

@end

@implementation KIVRouter

+ (instancetype)sharedInstance {
    static KIVRouter *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[KIVRouter alloc] init];
    });
    
    return sharedInstance;
}

- (void)registeRootVC:(UIViewController *)rootVc
{
    self.rootVC = rootVc;
}


- (NSString *)routeClassNameForkey:(NSString *)key
{
    if (key.length == 0) {
        return nil;
    }
    return [self.routerKeyMapList objectForKey:key];
    
}

#pragma mark - Accessor & config
- (NSDictionary *)routerKeyMapList
{
    return @{
             @"test1vc":@"VC1",
             @"test2vc":@"VC2",
             @"testIvc":@"Invalid",
             
            
             @"mainvc":@"ViewController",
             @"loglistvc":@"KIVLogVC",
             @"webreadervc":@"KIVWebVC",
             @"userinfovc":@"UserInfoVC",
             @"importlogvc":@"DemoWebServerVC",
             @"aboutvc":@"AboutViewController",
             @"advicevc":@"AdviceViewController",
             };
}

- (KIVVCTransition *)transition
{
    if (!_transition) {
        _transition = [[KIVVCTransition alloc] initSamVCTransitionWithPresentationAnimatorClassName:@"AnimatorSpring"];
    }
    return _transition;
}


#pragma mark - Jump to module VC
- (void)routeToModulesOfKey:(NSString *)key
{
    [self routeToModulesOfKey:key withRouteCompleteBlock:nil];
}

- (void)routeToModulesOfKey:(NSString *)key withRouteCompleteBlock:(KIVRouteCompleteBlock)routeCompleteBlock
{
    [self routeToModulesOfKey:key withParams:nil routeCompleteBlock:routeCompleteBlock];
}

- (void)routeToModulesOfKey:(NSString *)key withParams:(NSDictionary *)aParams
{
    [self routeToModulesOfKey:key withParams:aParams routeCompleteBlock:nil];
}

- (void)routeToModulesOfKey:(NSString *)key withParams:(NSDictionary *)aParams routeCompleteBlock:(KIVRouteCompleteBlock)routeCompleteBlock
{
    Class moduleClass = [self getModuleClassForKey:key];
    UIViewController *targetVC = nil;//[[UIViewController alloc] initWithNibName:NSStringFromClass(moduleClass) bundle:nil];
//    UIViewController *vc = [[UIViewController alloc] initWithNibName:NSStringFromClass(moduleClass) bundle:[NSBundle mainBundle]];
    if (!targetVC) {
        targetVC = [[moduleClass alloc] init];
    }

    if (!targetVC) {
        return;
    }
    targetVC.routerParamsDir = [aParams copy];
    if (self.beforeHandle) {
        self.beforeHandle(targetVC,nil);
    }
    if ([self.rootVC isKindOfClass:[UINavigationController class]]) {
        UINavigationController *rootNav = (UINavigationController *)self.rootVC;
        [rootNav pushViewController:targetVC animated:YES];
        return;
    }else if ([self.rootVC isKindOfClass:[UIViewController class]]){
        [self.rootVC presentViewController:targetVC animated:YES completion:^{
            if (routeCompleteBlock) {
                routeCompleteBlock(targetVC,nil);
            }
        }];
        return;
    }else{
        NSString *assertString = [NSString stringWithFormat:@"The value in the Config Map of this key:%@ is not a \"UIViewController\" ClassName",key];
        assert(assertString);
        return;
    }
//    if (self.afterHandle) {
//        self.afterHandle(targetVC,nil);
//    }
}

#pragma mark - Precent
//想办法解决两个key值跳转 的传值问题
- (NSDictionary *)middleParamArea
{
    return nil;
}

- (void)routerVCkey:(NSString *)fromKey toVCKey:(NSString *)toKey
{
    [self routerVCkey:fromKey toVCKey:toKey withParams:nil];
}

- (void)routerVCkey:(NSString *)fromKey toVCKey:(NSString *)toKey withParams:(NSDictionary *)dirParam
{
    [self routerVCkey:fromKey toVCKey:toKey withParams:dirParam completeBlock:nil];
}

- (void)routerVCkey:(NSString *)fromKey toVCKey:(NSString *)toKey withParams:(NSDictionary *)dirParam completeBlock:(KIVRouteCompleteBlock)routeCompleteBlock
{
    [self routerVCkey:fromKey toVCKey:toKey withParams:dirParam trasitionAnimatorClassName:nil completeBlock: routeCompleteBlock];
}

- (void)routerVCkey:(NSString *)fromKey toVCKey:(NSString *)toKey withParams:(NSDictionary *)dirParam trasitionAnimatorClassName:(NSString *)AnimatorClassName completeBlock:(KIVRouteCompleteBlock)routeCompleteBlock
{
    Class fromClass = [self getModuleClassForKey:fromKey];
    UIViewController *fromVC = nil;
    
    UINavigationController *rootNvc = (UINavigationController *)self.rootVC;
    for (UIViewController *itemVC in rootNvc.viewControllers) {
        if ([itemVC isKindOfClass:fromClass]) {
            fromVC = itemVC;
        }
    }
    if (!fromVC) {
        return;
    }
    
    Class toClass = [self getModuleClassForKey:toKey];
    UIViewController *toVC = [[toClass alloc] init];
    if (!toVC) {
        return;
    }
    
    //    [fromVC presentViewController:toVC animated:YES completion:^{
    //        NSLog(@"this is present vc from %@ to %@",fromVC,toVC);
    //    }];
    [self routerVC:fromVC toVC:toVC withParams:dirParam trasitionAnimatorClassName:AnimatorClassName completeBlock:routeCompleteBlock];
}


- (void)routerVC:(UIViewController *)fromVc toVC:(UIViewController *)toVc
{
    [self routerVC:fromVc toVC:toVc withParams:nil trasitionAnimatorClassName:nil completeBlock:nil];
}

- (void)routerVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC withParams:(NSDictionary *)dirParam trasitionAnimatorClassName:(NSString *)AnimatorClassName completeBlock:(KIVRouteCompleteBlock)routeCompleteBlock
{
    NSString *animator = AnimatorClassName;
    if (!NSClassFromString(animator)) {
        animator = @"AnimatorPopping";
    }
    KIVVCTransition *trasition = [[KIVVCTransition alloc] initSamVCTransitionWithPresentationAnimatorClassName:animator presentationControllerClassName:@"SAMDarkClubDataPickPC"];
    toVC.transitioningDelegate = trasition;
    [fromVC presentViewController:toVC animated:YES completion:^{
        NSLog(@"this is present vc from %@ to %@",fromVC,toVC);
    }];
}

- (void)routerVC:(UIViewController *)fromVC
            toVC:(UIViewController *)toVC
      withParams:(NSDictionary *)dirParam
vcTransition:(KIVVCTransition *)vcTransition
   completeBlock:(KIVRouteCompleteBlock)routeCompleteBlock
{
    toVC.transitioningDelegate = vcTransition;
    [fromVC presentViewController:toVC animated:YES completion:^{
        NSLog(@"this is present vc from %@ to %@",fromVC,toVC);
    }];
}

#pragma mark - LifeCycle
- (void)beforeRouterWithHandle:(KIVRouteHandleBlock)handleBlock
{
    self.beforeHandle = handleBlock;
}
- (void)afterRouterWithHandle:(KIVRouteHandleBlock)handleBlock
{
    self.afterHandle = handleBlock;
}


- (Class)getModuleClassForKey:(NSString *)key
{
    if (key.length == 0) {
        return nil;
    }
    NSString *className = [self.routerKeyMapList objectForKey:key];
    if (className.length == 0) {
        NSLog(@"Not find the vc of this key:%@",key);
        return nil;
    }
    Class moduleClass = NSClassFromString(className);
    if (!moduleClass) {
        NSLog(@"Invalid value in the Config Map of this key:%@, and the %@ object doesn't created!",key,key);
        return nil;
    }
    return moduleClass;
}

@end


@implementation UIViewController(KIVRouter)

- (NSDictionary *)routerParamsDir
{
    return  objc_getAssociatedObject(self, _cmd);
}

- (void)setRouterParamsDir:(NSDictionary *)aParamsDir
{
    objc_setAssociatedObject(self, @selector(routerParamsDir), aParamsDir, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (KIVRouteHandleBlock)routerhandleBlock
{
    return  objc_getAssociatedObject(self, _cmd);
}

- (void)setRouterhandleBlock:(KIVRouteHandleBlock)aHandleBlock
{
    objc_setAssociatedObject(self, @selector(routerhandleBlock), aHandleBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end;
