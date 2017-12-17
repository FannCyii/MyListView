//
//  KIVDSBaseRow.h
//  HomePage
//
//  Created by kivan on 02/11/2017.
//  Copyright © 2017 HomePage. All rights reserved.
//
#import <UIKit/UIKit.h>


/**
 item/row的点击效果

 @param listView 表示tableview或collectionview
 @param indexPath 位置信息
 */
typedef void (^SelectedBlock)(id listView, NSIndexPath *indexPath);

@interface KIVDSBaseRow : NSObject
@property (nonatomic, strong) NSString *cellClassName;
@property (nonatomic, strong, readonly) NSString *cellIdentifier;
@property (nonatomic, strong) id cellData;

@property (nonatomic, assign) BOOL hiddenRowBottomLine;

@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, strong) UIColor *rowColor;

@property (nonatomic, assign) BOOL canNotSelected;

#pragma mark - Cell Action
@property (nonatomic, copy) SelectedBlock selectedBlock;

@end
