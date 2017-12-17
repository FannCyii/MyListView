//
//  Demo_XMLParser.m
//  Demo_XMLParser
//
//  Created by kivan on 13/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "Demo_XMLParser.h"
//#import "NSXMLParser.h"

@interface Demo_XMLParser () <NSXMLParserDelegate>
@property (nonatomic, strong) NSXMLParser *xmlParser;
@end

@implementation Demo_XMLParser

- (instancetype)initWithData:(NSData *)aData
{
    self = [super init];
    if(self){
        NSData *data = [NSData dataWithContentsOfFile:@""];
        _xmlParser = [[NSXMLParser alloc] initWithData:aData];
        _xmlParser.delegate = self;
    }
    return self;
}

#pragma mark - Document handling methods
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"开始解析");
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"结束解析");
}

@end
