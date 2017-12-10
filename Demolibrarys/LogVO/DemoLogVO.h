//
//  DemoLogVO.h
//  Demolibrarys
//
//  Created by kivan on 10/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface DemoLogVO : JSONModel

@property (nonatomic, strong) NSString *logtitle;
@property (nonatomic, strong) NSString *logurl;
@property (nonatomic, strong) NSString *auther;
@property (nonatomic, strong) NSString *date;

@end
