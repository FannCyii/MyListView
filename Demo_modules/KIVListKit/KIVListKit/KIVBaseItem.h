//
//  KIVBaseItem.h
//  Demo_AboutList
//
//  Created by Fann on 16/01/2018.
//  Copyright © 2018 Fann. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 item点击回调

 @param data 传入数据
 @param list 点击的列表：可能是UITableView或UICollectionView
 @param indexPath 点击的位置
 */
typedef void(^KIVItemSelectedHandle)(id data,id list,NSIndexPath *indexPath);

@interface KIVBaseItem : NSObject

@property (nonatomic, strong) NSString *itemClassName;

@property (nonatomic, strong, readonly) NSString *itemIdentifier;


@property (nonatomic, strong) id itemData;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, strong) UIColor *itemColor;

/*
 点击处理 item优先处理，section的后处理，如果设置了section的这个选项则section下所有的item点击时都会触发
 */
@property (nonatomic, assign) KIVItemSelectedHandle selectedHandleBlock;

@end
