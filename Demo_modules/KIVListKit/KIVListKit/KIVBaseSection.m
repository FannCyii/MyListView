//
//  KIVBaseSection.m
//  Demo_AboutList
//
//  Created by Fann on 16/01/2018.
//  Copyright © 2018 Fann. All rights reserved.
//

#import "KIVBaseSection.h"

@interface KIVBaseSection()

@end

@implementation KIVBaseSection

#pragma mark - Accessor
- (NSMutableArray *)items
{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}



#pragma mark -Insert Method
- (void)addItem:(KIVBaseItem *)item
{
    if (![self verifiedItems:item]) {
        NSLog(@"[KIVBaseSection] the items is invalid:<item = %@>",item);
        return;
    }
    
    [self.items addObject:item];
}
- (void)addItems:(NSArray<KIVBaseItem *> *)items
{
    if (items.count == 0) {
        return;
    }
    for (KIVBaseItem *item in items) {
        [self addItem:item];
    }
}

- (void)insertItem:(KIVBaseItem *)item atIndexe:(NSInteger)index
{
    if (![self verifiedItems:item] && index < 0 && index > self.items.count) {
        return;
    }
    [self.items insertObject:item atIndex:index];
}

#pragma mark - Tools
- (BOOL )verifiedItems:(KIVBaseItem *)item
{
    if (!item || item.itemClassName.length == 0) {
        return  NO;
    }
    return YES;
}

@end
