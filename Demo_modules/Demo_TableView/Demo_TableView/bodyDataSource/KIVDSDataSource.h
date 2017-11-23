//
//  KIVDSDataSource.h
//  HomePage
//
//  Created by kivan on 02/11/2017.
//  Copyright © 2017 HomePage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+KIVDS.h"

UIKIT_EXTERN NSString * const BASE_CELL_IDENTIFIER;

@class KIVDSBaseSection;



@interface KIVDSDataSource : NSObject <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) id delegate;

//- (instancetype)initWithTableView:(UITableView *)tableView;

//- (void)addSection:(KIVDSBaseSection *)section;
//- (void)addSections:(NSArray <KIVDSBaseSection *>*)sections;

//- (void)reload;
//- (void)clearData;

- (void)connectDataWithSections:(NSArray <KIVDSBaseSection *> *)sections;


@end
