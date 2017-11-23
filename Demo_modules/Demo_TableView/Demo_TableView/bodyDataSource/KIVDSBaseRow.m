//
//  KIVDSBaseRow.m
//  HomePage
//
//  Created by kivan on 02/11/2017.
//  Copyright © 2017 HomePage. All rights reserved.
//

#import "KIVDSBaseRow.h"

@implementation KIVDSBaseRow

- (NSString *)cellIdentifier
{
    return self.cellClassName;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"[className:%@-data:%@-height:%f]",self.cellClassName,self.cellData,self.rowHeight];
}

@end
