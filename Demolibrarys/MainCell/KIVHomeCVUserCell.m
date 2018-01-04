//
//  KIVHomeCVUserCell.m
//  Demolibrarys
//
//  Created by Fann on 02/01/2018.
//  Copyright © 2018 kivan. All rights reserved.
//

#import "KIVHomeCVUserCell.h"

@implementation KIVHomeCVUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 100, 20)];
    [self.contentView addSubview:button];
    button.backgroundColor = [UIColor purpleColor];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)buttonAction:(UIButton *)button
{
    NSLog(@"test present button");
    //这里如何获取参数 由 mainvc 传到 webreadervc
//    [[KIVRouter sharedInstance] routerVCkey:@"mainvc" toVCKey:@"webreadervc"];
    [[KIVRouter sharedInstance] routerVCkey:@"mainvc" toVCKey:@"webreadervc" withParams:nil trasitionAnimatorClassName:@"AnimatorSpring" completeBlock:nil];
}


@end
