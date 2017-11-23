//
//  KIVDSBaseTVCell.h
//  HomePage
//
//  Created by kivan on 02/11/2017.
//  Copyright © 2017 HomePage. All rights reserved.
//

#import <UIKit/UIKit.h>


@class KIVDSBaseSection;
@interface KIVDSBaseTVCell : UITableViewCell

+ (NSString *)cellIdentifier;
@property (nonatomic, weak) id delegate;
@property (nonatomic, assign) BOOL hiddenBottomLine;
//###
//需重写的方法
//###
- (void)updateDataWithData:(id)aData;
- (void)didSelectedWithSection:(KIVDSBaseSection *)section index:(NSUInteger)index;

@end
