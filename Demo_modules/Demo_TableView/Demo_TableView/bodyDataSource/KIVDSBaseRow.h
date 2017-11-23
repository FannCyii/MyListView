//
//  KIVDSBaseRow.h
//  HomePage
//
//  Created by kivan on 02/11/2017.
//  Copyright © 2017 HomePage. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface KIVDSBaseRow : NSObject
@property (nonatomic, strong) NSString *cellClassName;
@property (nonatomic, strong, readonly) NSString *cellIdentifier;
@property (nonatomic, strong) id cellData;

@property (nonatomic, assign) BOOL hiddenRowBottomLine;

@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, strong) UIColor *rowColor;

@property (nonatomic, assign) BOOL canNotSelected;
@end
