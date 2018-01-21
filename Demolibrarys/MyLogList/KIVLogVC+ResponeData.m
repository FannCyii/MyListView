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

@interface KIVLogVC ()
@property (nonatomic, strong) UITableView *mainListTV;
@end

@implementation KIVLogVC (ResponeData)

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
        
//        KIVDSBaseSection *section = [KIVDSBaseSection new];
//        //这里可以优化成indexPath
//        section.didSelectedBlock = ^(UITableView *tableView, KIVDSBaseSection *section, NSUInteger index) {
//            KIVDSBaseRow *row = [section.rows objectAtIndex:index];
//            DemoLogVO *vo = (DemoLogVO *)row.cellData;
//            KIVWebVC *webVc = [[KIVWebVC alloc] init];
//            webVc.url = vo.logurl;
//            [self.navigationController pushViewController:webVc animated:YES];
//        };
        
        KIVTVCellItem *row = [KIVTVCellItem new];
        row.itemClassName = @"KIVLogMainCell";
        row.height = 100;
        row.itemData = vo;
        __weak typeof(self)weakSelf = self;
        
        row.selectedHandleBlock = ^(id data, id list, NSIndexPath *indexPath) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            NSArray *array = [(UITableView *)list sections];
            KIVTVCellSection *section = [array objectAtIndex:indexPath.section];
            KIVTVCellItem *row = [section.items objectAtIndex:indexPath.row];
            DemoLogVO *vo = (DemoLogVO *)row.itemData;
            KIVWebVC *webVc = [[KIVWebVC alloc] init];
            webVc.url = vo.logurl;
            [strongSelf.navigationController pushViewController:webVc animated:YES];
        };
        //更新cell
//        [self.mainListTV addRow:row atSectionInIndex:0];
        [self.mainListTV kiv_reloadData];
    }
}



@end
