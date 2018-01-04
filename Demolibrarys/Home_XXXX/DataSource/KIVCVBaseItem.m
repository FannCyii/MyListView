//
//  KIVCVBaseItem.m
//  Demolibrarys
//
//  Created by kivan on 13/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "KIVCVBaseItem.h"

@implementation KIVCVBaseItem

#pragma mark - Accessor

- (void)setHeight:(CGFloat)height
{
    if(height <= 0){
        _height = 0.01f;
    }
    _height = height;
    self.rowHeight = _height;
}

- (void)setWith:(CGFloat)with
{
    if(with <= 0){
        _with = 0.01f;
    }
    _with = with;
}

@end
