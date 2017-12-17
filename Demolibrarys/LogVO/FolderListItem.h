//
//  FolderListItem.h
//  Demolibrarys
//
//  Created by kivan on 12/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "ElementInfo.h"
#import "ArticleListItem.h"

@interface FolderListItem : ElementInfo
@property (nonatomic, strong) NSNumber *fId;
@property (nonatomic, strong) NSString *fPic;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *aDescription;
@property (nonatomic, strong) NSString *myNotes;

@property (nonatomic, strong) NSMutableArray<ElementInfo *> *subElements;
@end
