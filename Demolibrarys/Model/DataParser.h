//
//  DataParser.h
//  Demolibrarys
//
//  Created by kivan on 15/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FolderListItem;
@interface DataParser : NSObject
- (instancetype)initWithData:(NSData *)aData;

@property (nonatomic, strong) FolderListItem *rootFolder;

- (FolderListItem *)gumboXMLParser:(NSData *)aData;
//- (NSDictionary *)parserData:(NSData *)aData;
//- (NSDictionary *)parserString:(NSString *)string;
@end
