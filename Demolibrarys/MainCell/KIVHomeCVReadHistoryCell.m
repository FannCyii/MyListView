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
@property (nonatomic, strong) KIVTableViewProtocol *dataSource;
@end

@implementation KIVHomeCVReadHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:self.tableView];
    [self.tableView autoPinEdgesToSuperviewEdges];

    self.dataSource = [KIVTableViewProtocol new];
    [self.tableView registeKivProtocol:self.dataSource];
    
    [self dataHandle];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logsArchived:) name:NOTIFICATION_ARCHIVER_HISTORIES object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)logsArchived:(NSNotification *)notification
{
    if ([notification.name isEqualToString:NOTIFICATION_ARCHIVER_HISTORIES]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dataHandle];
        });
    }
}

- (void)dataHandle
{
//    [self.tableView clearData];
    
    KIVTVCellSection *section = [[KIVTVCellSection alloc] init];
    KIVArchiverManager *manager = [[KIVArchiverManager alloc] initWithIdentifior:FOLDER_ARTICLE_READ_HISTORIES completeHandle:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_ARCHIVER_HISTORIES object:nil];
    }];
    
    NSArray *histories = [[[manager getAllLogs] reverseObjectEnumerator] allObjects];
    for (NSDictionary *dir in histories) {
        ElementInfo *info = dir[LOGSCONTENT];
        KIVTVCellItem *row = [[KIVTVCellItem alloc]init];
        row.itemClassName = @"HistroyReadTVCell";
        row.height = 60;
        row.itemData = info;
        [section addItem:row];
    }
    
    section.selectedHandleBlock = ^(id data, id list, NSIndexPath *indexPath) {
        NSArray *sections = [(UITableView *)list sections];
        KIVTVCellSection *section = [sections objectAtIndex:indexPath.section];
        
        KIVTVCellItem *row = [section.items objectAtIndex:indexPath.row];
        ElementInfo *info = row.itemData;
        [[KIVRouter sharedInstance] routeToModulesOfKey:@"webreadervc" withParams:@{@"url":info.aUrl}];
    };
    
    [self.tableView addSections:@[section]];
    [self.tableView kiv_reloadData];
    
}




@end
