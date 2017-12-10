//
//  ViewController.m
//  Demolibrarys
//
//  Created by kivan on 16/11/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "ViewController.h"
#import "DemoTVC.h"
#import "KIVLogVC.h"
#import "KIVTogetherTouchRecogizer.h"
#import "DemoWebServerVC.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *tempView;
@property (nonatomic, strong) KIVTogetherTouchRecogizer *touchr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.touchr = [KIVTogetherTouchRecogizer new];
//
//    [self.touchr registerTouchView:self.tempView];
    
    
//    const char * chr = "abcdef";
//    NSString *str =@(chr);
//    NSLog(@"%@",str);
    
    NSScanner *scanner = [NSScanner scannerWithString:@"abc123efdkkkkk"];

//    while (![scanner isAtEnd]) {
////        BOOL bo = [scanner scanString:@"k" intoString:&value];
//        BOOL bo = [scanner scanUpToString:@"k" intoString:&value];
//        NSLog(@"%d-%@",bo,value);
//    }
    
    int a;
    BOOL bo = [scanner scanInt:&a];
    NSLog(@"%d-%d",bo,a);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToTVCAction:(UIButton *)sender {
    DemoTVC *tvc = [DemoTVC new];
    [self.navigationController pushViewController:tvc animated:YES];
}

- (IBAction)goToListLogAction:(UIButton *)sender {
    KIVLogVC *tvc = [KIVLogVC new];
    [self.navigationController pushViewController:tvc animated:YES];
}
- (IBAction)openWebServer:(UIButton *)sender {
    [self.navigationController pushViewController:[[DemoWebServerVC alloc] init] animated:YES];
}

@end
