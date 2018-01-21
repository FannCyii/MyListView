//
//  KIVCVCellItem.m
//  Demo_AboutList
//
//  Created by Fann on 16/01/2018.
//  Copyright © 2018 Fann. All rights reserved.
//

#import "KIVCVCellItem.h"

@implementation KIVCVCellItem

- (NSString *)description
{
    return [NSString stringWithFormat:@"CV cell Item, className:%@ size:<w:%.2f,h:%.2f> color:%@" ,self.itemClassName,self.width,self.height,self.itemColor];
}


@end
