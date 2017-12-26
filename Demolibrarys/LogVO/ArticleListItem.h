//
//  ArticleListItem.h
//  Demolibrarys
//
//  Created by kivan on 12/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "ElementInfo.h"

@interface ArticleListItem : ElementInfo

@property (nonatomic, strong) NSNumber *aId;
@property (nonatomic, strong) NSString *apic;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *aDescription;
@property (nonatomic, strong) NSString *myNotes;
@end
