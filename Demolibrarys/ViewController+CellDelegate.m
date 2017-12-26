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
- (void)kivHomeCVHeaderCell:(KIVHomeCVHeaderCell *)cell didReturnWihtTextField:(UITextField *)textField
{
    KIVWebVC *webVC = [[KIVWebVC alloc] init];
    webVC.url = textField.text;
    
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)kivHomeCVMiddelCell:(KIVHomeCVMiddelCell *)cell selectedIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        KIVLogVC *vc = [KIVLogVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        KIVWebVC *webVC = [[KIVWebVC alloc] init];
        webVC.url = @"www.google.com";
        [self.navigationController pushViewController:webVC animated:YES];
    }
}


@end
