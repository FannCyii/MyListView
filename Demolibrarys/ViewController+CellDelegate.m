//
//  ViewController+CellDelegate.m
//  Demolibrarys
//
//  Created by kivan on 25/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "ViewController+CellDelegate.h"
#import "KIVWebVC.h"
#import "KIVLogVC.h"



@implementation ViewController (CellDelegate)

- (void)kivSearchHeaderView:(KIVSearchHeaderView *)cell didReturnWihtTextField:(UITextField *)textField
{
    [[KIVRouter sharedInstance] routeToModulesOfKey:@"webreadervc" withParams:@{@"url":textField.text}];
}

//- (void)kivHomeCVHeaderCell:(KIVHomeCVHeaderCell *)cell didReturnWihtTextField:(UITextField *)textField
//{
//    KIVWebVC *webVC = [[KIVWebVC alloc] init];
//    webVC.url = textField.text;
//    
//    [self.navigationController pushViewController:webVC animated:YES];
//}

- (void)kivHomeCVMiddelCell:(KIVHomeCVMiddelCell *)cell selectedIndexPath:(NSIndexPath *)indexPath cellData:(id)aData
{
    if(indexPath.row == 0){
        KIVWebVC *webVC = [[KIVWebVC alloc] init];
        webVC.url = @"www.google.com";
        [self.navigationController pushViewController:webVC animated:YES];
    }else{
        KIVLogVC *vc = [KIVLogVC new];
        vc.logsData = (NSDictionary *)aData;
        [self.navigationController pushViewController:vc animated:YES];
    }
}




@end
