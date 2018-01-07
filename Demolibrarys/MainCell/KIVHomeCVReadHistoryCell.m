//
//  KIVHomeCVReadHistoryCell.m
//  Demolibrarys
//
//  Created by Fann on 02/01/2018.
//  Copyright © 2018 kivan. All rights reserved.
//

#import "KIVHomeCVReadHistoryCell.h"
#import "KIVArchiverManager.h"
#import "ElementInfo.h"

@interface KIVHomeCVReadHistoryCell()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) KIVDSDataSource *dataSource;
@end

@implementation KIVHomeCVReadHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    
    [self.contentView addSubview:self.tableView];
    [self.tableView autoPinEdgesToSuperviewEdges];

    self.dataSource = [KIVDSDataSource new];
    
    [self.tableView registerKivDataSource:self.dataSource];
    
    [self dataHandle];
    
}

- (void)dataHandle
{
    KIVDSBaseSection *section = [[KIVDSBaseSection alloc] init];
    KIVArchiverManager *manager = [[KIVArchiverManager alloc] initWithIdentifior:FOLDER_ARTICLE_READ_HISTORIES];
    
    NSArray *histories = [manager getAllLogs];
    for (NSDictionary *dir in histories) {
        ElementInfo *info = dir[LOGSCONTENT];
        KIVDSBaseRow *row = [[KIVDSBaseRow alloc]init];
        row.cellClassName = @"HistroyReadTVCell";
        row.rowHeight = 60;
        row.cellData = info;
        [section insertRow:row];
    }
    
    section.didSelectedBlock = ^(UITableView *tableView, KIVDSBaseSection *section, NSUInteger index) {
        KIVDSBaseRow *row = [section.rows objectAtIndex:index];
        ElementInfo *info = row.cellData;
        [[KIVRouter sharedInstance] routeToModulesOfKey:@"webreadervc" withParams:@{@"url":info.aUrl}];
    };
    [self.tableView addSection:section];
    [self.tableView refreshData];
    
}




@end
