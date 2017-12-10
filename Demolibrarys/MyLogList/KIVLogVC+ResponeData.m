//
//  KIVLogVC+ResponeData.m
//  Demolibrarys
//
//  Created by kivan on 11/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "KIVLogVC+ResponeData.h"
#import "Demo_Network.h"
#import "DemoLogVO.h"
#import "KIVDSBaseRow.h"
#import "KIVDSBaseSection.h"
#import "KIVWebVC.h"
#import "KIVDSDataSource.h"

@interface KIVLogVC ()
@property (nonatomic, strong) UITableView *mainListTV;
@end

@implementation KIVLogVC (ResponeData)

- (void)webServer:(Demo_Network *)webServer startUrl:(NSURL *)url
{
    
}

- (void)webServer:(Demo_Network *)webServer responsePath:(NSString *)path responseData:(id)aData error:(NSError *)error
{
    if([path isEqualToString:@"/1"]){
//        NSError *error = nil;
        //        if([aData isKindOfClass:[NSDictionary class]]){
        //            DemoLogVO *vo = [[DemoLogVO alloc] initWithDictionary:(NSDictionary *)aData error:&error];
        //            NSLog(@"vo:%@",vo);
        //        }
        NSLog(@"====返回数据%@",aData);
        [[NSUserDefaults standardUserDefaults] setObject:aData forKey:@"log.info.deme.list"];
        
        DemoLogVO *vo = [DemoLogVO new];
        vo.logtitle = aData[@"logtitle"];
        vo.logurl = aData[@"logurl"];
        
        KIVDSBaseSection *section = [KIVDSBaseSection new];
        //这里可以优化成indexPath
        section.didSelectedBlock = ^(UITableView *tableView, KIVDSBaseSection *section, NSUInteger index) {
            KIVDSBaseRow *row = [section.rows objectAtIndex:index];
            DemoLogVO *vo = (DemoLogVO *)row.cellData;
            KIVWebVC *webVc = [[KIVWebVC alloc] init];
            webVc.url = vo.logurl;
            [self.navigationController pushViewController:webVc animated:YES];
        };
        
        KIVDSBaseRow *row = [KIVDSBaseRow new];
        row.cellClassName = @"KIVLogMainCell";
        row.rowHeight = 100;
        row.cellData = vo;
        [section insertRow:row];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mainListTV addSection:section];
            [self.mainListTV refreshData];
        });
    
    }
}



@end
