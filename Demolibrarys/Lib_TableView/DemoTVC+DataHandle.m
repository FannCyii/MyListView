//
//  DemoTVC+DataHandle.m
//  Demolibrarys
//
//  Created by kivan on 16/11/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "DemoTVC+DataHandle.h"
#import "KIVDSDataSource.h"
#import "KIVDSBaseRow.h"
#import "KIVDSBaseSection.h"
#import "KIVDemo01Cell.h"


@interface DemoTVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) KIVDSDataSource *dataSrouce;

@end

@implementation DemoTVC (DataHandle)

- (void)dataHandle
{
    self.dataSrouce = [KIVDSDataSource new];
    self.dataSrouce.delegate = self;
    [self.tableView registerKivDataSource:self.dataSrouce];
    
    KIVDSBaseSection *section1 = [KIVDSBaseSection new];
    KIVDSBaseRow *row1 = [KIVDSBaseRow new];
    row1.rowColor = [UIColor yellowColor];
    row1.hiddenRowBottomLine = NO;

    for (int i = 100; i > 0; --i) {
        KIVDSBaseRow *row = [KIVDSBaseRow new];
        row.cellData = @(i).stringValue;
        row.cellClassName = @"KIVDemo01Cell";
        [section1 insertRow:row];
    }

    [self.tableView addSection:section1];
    [self.tableView refreshData];

}

- (void)kivDemo01Cell:(KIVDemo01Cell *)cell didSelectedButton:(UIButton *)button
{
    [self.tableView updataCell:cell withData:@"哈哈哈哈哈"];
}

@end
