//
//  KIVBaseCellInterface.h
//  Demo_AboutList
//
//  Created by Fann on 16/01/2018.
//  Copyright © 2018 Fann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KIVBaseItem.h"

@protocol KIVBaseCellInterface <NSObject>


@optional

- (NSString *)cellIdentifier;
//updateCellWithItem: 和updataCellWithItemData:只能二选一来实现，会优先调用updataCellWithItemData:
- (void)updateCellWithItem:(KIVBaseItem *)item;
- (void)updataCellWithItemData:(id)itemData;

/**
 点击了cell 在cell反馈到具体cell的操作

 @param itemData itemData 所属cell的数据
 @param indexPath 所属cell的位置IndePath
 @param list cell所属的列表：UITableView或UICollectionView
 */
- (void)didSeletedWithData:(id)itemData withIndexPath:(NSIndexPath *)indexPath ofList:(id)list;
@end


//@interface KIVBaseCellInterface : NSObject
//
//@end

