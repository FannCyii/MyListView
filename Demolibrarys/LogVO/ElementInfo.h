//
//  ElementInfo.h
//  Demolibrarys
//
//  Created by kivan on 16/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ElementInfoType) {
    ElementInfoTypeOfEmpty,
    ElementInfoTypeOfFolder,
    ElementInfoTypeOfArticle,
};

@interface ElementInfo : NSObject <NSCoding>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *addDate;
@property (nonatomic, strong) NSString *lastModified;
@property (nonatomic, strong) NSString *personalToolbarFolder;
@property (nonatomic, strong) NSString *iconURI;
@property (nonatomic, strong) NSString *aUrl;
@property (nonatomic, assign) ElementInfoType elementType;

@end
