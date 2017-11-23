//
//  KIVDSBaseSection.h
//  HomePage
//
//  Created by kivan on 02/11/2017.
//  Copyright © 2017 HomePage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KIVDSBaseRow.h"

@class KIVDSBaseSection;
@class UITableView;

typedef void (^RowSelectedCompleteBlock)(UITableView *tableView,KIVDSBaseSection *section,NSUInteger index);

@interface KIVDSBaseSection : NSObject
@property (nonatomic, strong, readonly) NSMutableArray<KIVDSBaseRow *> *rows;

@property (nonatomic, assign) BOOL showSectionHeader;
@property (nonatomic, assign) BOOL showSectionFooter;

@property (nonatomic, assign) CGFloat sectionHeaderHeight;
@property (nonatomic, assign) CGFloat sectionFooterHeight;

@property (nonatomic, strong) NSString *headerTitle;
@property (nonatomic, strong) NSString *footerTitle;

- (void)insertRow:(KIVDSBaseRow *)row;
- (void)insertRow:(KIVDSBaseRow *)row atIndex:(NSUInteger)index;
- (void)insertFirsteRow:(KIVDSBaseRow *)row;
- (void)insertAtLastRow:(KIVDSBaseRow *)row;
- (void)insertRows:(NSArray<KIVDSBaseRow *> *)rows;

- (void)clearRows;
- (void)removeRow:(KIVDSBaseRow *)row;
- (void)removeRowAtIndex:(NSUInteger)rowIndex;

@property (nonatomic, copy) RowSelectedCompleteBlock didSelectedBlock;

#pragma mark - 批处理
- (void)addTemplateRow:(KIVDSBaseRow *)row withArrayData:(NSArray *)data;

@end
