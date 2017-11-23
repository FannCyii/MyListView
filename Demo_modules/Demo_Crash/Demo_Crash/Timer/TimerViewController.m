//
//  TimerViewController.m
//  Demo_AOP_Crash
//
//  Created by kivan on 17/10/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "TimerViewController.h"
#import "KIVTimer.h"

@interface TimerViewController ()
@property (nonatomic, strong) KIVTimer *timer;
@property (nonatomic, assign) NSInteger timerIndex;
@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timerIndex = 60;
    
    self.timer = [KIVTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(testTime) userInfo:nil repeats:YES];
    
}

- (void)testTime{
    NSLog(@"%ld",(long)self.timerIndex );
    self.timerIndex = self.timerIndex - 1;
    if (self.timerIndex == 0) {
        self.timerIndex = 60;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [self.timer invalidate];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
