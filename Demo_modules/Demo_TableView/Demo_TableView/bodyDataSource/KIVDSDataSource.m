//
//  KIVDSDataSource.m
//  HomePage
//
//  Created by kivan on 02/11/2017.
//  Copyright © 2017 HomePage. All rights reserved.
//

#import "KIVDSDataSource.h"
#import "KIVDSBaseTVCell.h"

#import "KIVDSBaseSection.h"
#import "KIVDSBaseRow.h"
#import "NSArray+SafeArray.h"

NSString * const BASE_CELL_IDENTIFIER = @"KIVDSBaseTVCell_Base";

@interface KIVDSDataSource ()
@property (nonatomic, strong) NSArray <KIVDSBaseSection *> *sections;
@property (nonatomic, strong) NSMutableArray *indexTitles;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation KIVDSDataSource

//- (instancetype)initWithTableView:(UITableView *)tableView
//{
//    self = [super init];
//    if(self){
//        self.tableView = tableView;
//        self.tableView.dataSource = self;
//        self.tableView.delegate = self;
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    }
//    return self;
//}

- (void)connectDataWithSections:(NSArray <KIVDSBaseSection *> *)sections
{
    self.sections = sections;
    NSLog(@"%ld",self.sections.count);
}

- (void)reload
{
    [self.tableView reloadData];
}

- (void)clearData
{
//    [self.sections removeAllObjects];
    self.indexTitles = nil;
}


//- (NSArray<KIVDSBaseSection *> *)sections{
//    if(!_sections){
//        _sections = [NSMutableArray<KIVDSBaseSection *> array];
//    }
//    return _sections;
//}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [(KIVDSBaseSection *)[self.sections objectAtIndex:section] headerTitle];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return [(KIVDSBaseSection *)[self.sections objectAtIndex:section] footerTitle];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[(KIVDSBaseSection *)[self.sections objectAtIndex:section] rows] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KIVDSBaseSection *section = [self.sections objectAtIndex:indexPath.section];
    KIVDSBaseRow *row = [section.rows objectAtIndex:indexPath.row];
    KIVDSBaseTVCell *cell;
    NSString *cellIdentifier = row.cellIdentifier;
    if(cellIdentifier.length == 0){
        cellIdentifier = BASE_CELL_IDENTIFIER;
    }
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [cell updateDataWithData:row.cellData];
    cell.delegate = self.delegate;
    if(row.rowColor){
        cell.backgroundColor = row.rowColor;
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }
    cell.hiddenBottomLine = row.hiddenRowBottomLine;
    
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.indexTitles;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    NSInteger sectionIndex = index;
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:sectionIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return sectionIndex;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KIVDSBaseSection *section = [self.sections objectAtIndex:indexPath.section];
    KIVDSBaseRow *row = [section.rows objectAtIndex:indexPath.row];
    if(row.rowHeight < 0.1){
        return 45;
    }
    return row.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    KIVDSBaseSection *sec = [self.sections objectAtIndex:section];
    if(!sec.showSectionHeader && sec.sectionHeaderHeight < 0.1){
        return 0.01;
    }
    return sec.sectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    KIVDSBaseSection *sec = [self.sections objectAtIndex:section];
    if(!sec.showSectionFooter && sec.sectionFooterHeight < 0.1){
        return 0.01;
    }
    return sec.sectionFooterHeight;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KIVDSBaseSection *section = [self.sections objectAtIndex:indexPath.section];
    KIVDSBaseRow *row = [section.rows objectAtIndex:indexPath.row];
    if(!row.canNotSelected){
        //优先条用row的点击事件
        if(row.selectedBlock){
            row.selectedBlock(tableView, indexPath);
        }else if(section.didSelectedBlock){
            section.didSelectedBlock(tableView, section, indexPath.row);
        }
        KIVDSBaseTVCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell didSelectedWithSection:section index:indexPath.row];
    }

}


@end
