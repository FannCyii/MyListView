//
//  KIVBaseSection.h
//  Demo_AboutList
//
//  Created by Fann on 16/01/2018.
//  Copyright © 2018 Fann. All rights reserved.
//

#import "KIVBaseItem.h"

@interface KIVBaseSection : KIVBaseItem
@property (nonatomic, strong) NSMutableArray *items;

- (void)addItem:(KIVBaseItem *)item;
- (void)addItems:(NSArray *)items;

- (void)insertItem:(KIVBaseItem *)item atIndexe:(NSInteger)index;

@end
