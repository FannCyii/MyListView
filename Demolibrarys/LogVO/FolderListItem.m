//
//  FolderListItem.m
//  Demolibrarys
//
//  Created by kivan on 12/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "FolderListItem.h"

@implementation FolderListItem

- (instancetype)init{
    self = [super init];
    if(self){
        _subElements = [NSMutableArray array];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.addDate forKey:@"addDate"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.lastModified forKey:@"lastModified"];
    [aCoder encodeObject:self.personalToolbarFolder forKey:@"personalToolbarFolder"];
    [aCoder encodeObject:self.iconURI forKey:@"iconURI"];
    [aCoder encodeObject:self.aUrl forKey:@"aUrl"];
    [aCoder encodeObject:@(self.elementType )forKey:@"elementType"];
    [aCoder encodeObject:self.subElements forKey:@"subElements"];

}


- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self){
        self.addDate = [aDecoder decodeObjectForKey:@"addDate"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.lastModified = [aDecoder decodeObjectForKey:@"lastModified"];
        self.personalToolbarFolder = [aDecoder decodeObjectForKey:@"personalToolbarFolder"];
        self.iconURI = [aDecoder decodeObjectForKey:@"iconURI"];
        self.aUrl = [aDecoder decodeObjectForKey:@"aUrl"];
        NSNumber *type = [aDecoder decodeObjectForKey:@"elementType"];
        self.elementType = type.integerValue;
        NSArray *array = [aDecoder decodeObjectForKey:@"subElements"];
        self.subElements = [array mutableCopy];
        
    }
    return self;
}




@end
