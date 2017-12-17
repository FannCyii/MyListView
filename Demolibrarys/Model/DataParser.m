//
//  DataParser.m
//  Demolibrarys
//
//  Created by kivan on 15/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "DataParser.h"
#import "XMLReader.h"
//#import "DataParser+XMLParser.h"
#import <ObjectiveGumbo.h>
#import "FolderListItem.h"
#import "ArticleListItem.h"

@interface DataParser ()
//@property (nonatomic, strong) NSXMLParser *xmlParser;


//@property (nonatomic, strong) NSMutableArray * foldders;
//@property (nonatomic, strong) NSMutableArray * articles;
//@property (nonatomic, strong) NSMutableString *currentElementValue;



@end


@implementation DataParser

- (instancetype)initWithData:(NSData *)aData
{
    self = [super init];
    if(self){
       _rootFolder = [self gumboXMLParser:aData];
    }
    return self;
}

- (FolderListItem *)gumboXMLParser:(NSData *)aData
{
    FolderListItem * rootFolder = [FolderListItem new];
    
    OGNode* doc1 = [ObjectiveGumbo parseNodeWithData:aData];
    NSArray * body = [doc1 elementsWithTag:GUMBO_TAG_BODY];
    for (OGElement *element in body) {
        ElementInfo *reEle = [self recursionElement:element withSuperElement:rootFolder];
        if(reEle){
            [rootFolder.subElements addObject:reEle];
        }
    }
    return rootFolder;
}

//递归查找
- (ElementInfo *)recursionElement:(OGElement *)element withSuperElement:(FolderListItem *)superFolder
{
    if([element isKindOfClass:[OGText class]]){
        OGText *text = (OGText *)element;
        if(text.isWhitespace){
            return nil;
        }
        NSLog(@"========:%@",text.text);
        OGElement *parent = (OGElement *)text.parent;
        if(parent.tag == GUMBO_TAG_H3){
            FolderListItem *folder = [FolderListItem new];
            folder.title = text.text;
            folder.addDate = parent.attributes[@"add_date"];
            folder.lastModified = parent.attributes[@"last_modified"];
            folder.personalToolbarFolder = parent.attributes[@"personal_toolbar_folder"];
            folder.elementType = ElementInfoTypeOfFolder;
            return folder;
        }else if(parent.tag == GUMBO_TAG_A){
            //文章
            ArticleListItem *article = [ArticleListItem new];
            article.title = text.text;
            article.addDate = parent.attributes[@"add_date"];
            article.iconURI = parent.attributes[@"icon"];
            article.aUrl = parent.attributes[@"href"];
            article.elementType = ElementInfoTypeOfArticle;
            return article;
        }
        return nil;
    }

    for (OGElement *el in element.children) {
        ElementInfo * reEle = nil;
        if([superFolder.subElements lastObject].elementType == ElementInfoTypeOfFolder && [el isKindOfClass:[OGElement class]] && el.tag == GUMBO_TAG_DL){
            FolderListItem *folder = (FolderListItem *)[superFolder.subElements lastObject];
            reEle = [self recursionElement:el withSuperElement:folder];
        }else{
            reEle = [self recursionElement:el withSuperElement:superFolder];
        }
        
        if(reEle){
            [superFolder.subElements addObject:reEle];
        }
    }
    
    return nil;
}



@end
