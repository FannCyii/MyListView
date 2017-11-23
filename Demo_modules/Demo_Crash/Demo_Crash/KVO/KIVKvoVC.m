//
//  KIVKvoVC.m
//  Demo_AOP_Crash
//
//  Created by kivan on 12/10/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "KIVKvoVC.h"
#import "KIVObserver.h"
#import "KIVChangedObject.h"

@interface KIVKvoVC ()
@property (nonatomic, strong) NSString *testString;
@property (nonatomic, strong) NSString *testString2;
@property (nonatomic, strong) NSString *testString3;
@property (nonatomic, strong) KIVObserver *observer;
@property (nonatomic, strong) KIVObserver *observer2;
@end

@implementation KIVKvoVC
- (void)dealloc
{
    //这里移除通知，不会崩溃
    [self removeObserver:self.observer forKeyPath:@"testString2"];
    [self removeObserver:self.observer forKeyPath:@"testString2"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self kvoCrash];
}

- (void)kvoCrash
{
    self.observer = [KIVObserver new];
    self.observer2 = [KIVObserver new];
    [self addObserver:self.observer forKeyPath:@"testString" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self.observer forKeyPath:@"testString" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
//    [self addObserver:self.observer forKeyPath:@"testString2" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
//    [self addObserver:self.observer2 forKeyPath:@"testString2" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
//    [self addObserver:self.observer2 forKeyPath:@"testString2" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
    self.testString = @"123423";
//    self.testString2 = @"aaaaaa";
}

@end
