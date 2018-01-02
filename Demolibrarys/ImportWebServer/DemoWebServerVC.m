//
//  DemoWebServerVC.m
//  Demolibrarys
//
//  Created by kivan on 10/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "DemoWebServerVC.h"
#import "Demo_Network.h"
#import "DemoLogVO.h"
#import "DataParser.h"
#import "CommonHeader.h"
#import "KIVArchiverManager.h"

@interface DemoWebServerVC () <DemoWebServerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *serverURLLabel;
@property (nonatomic, strong) Demo_Network *network;
@property (weak, nonatomic) IBOutlet UILabel *webStatusLabel;
@end

@implementation DemoWebServerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.network = [Demo_Network new];
    self.network.delegate = self;
    [self.network startServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)dealloc
{
    [self.network stopWebServer];
}

#pragma mark -DemoWebServerDelegate

- (void)webServer:(Demo_Network *)webServer startUrl:(NSURL *)url
{
    self.serverURLLabel.text = [NSString stringWithFormat:@"%@",url];
    if(url.absoluteString.length == 0){
        self.webStatusLabel.text = @"服务器启动失败";
    }else{
        self.webStatusLabel.text = @"服务器启动成功";
    }
}

- (void)webServer:(Demo_Network *)webServer responsePath:(NSString *)path responseData:(id)aData error:(NSError *)error
{
    if(!error && [path isEqualToString:@"/1"]){
        NSString *logs = [aData valueForKey:@"comment"];
        NSString *logsName = [aData valueForKey:@"logtitle"];
        if (logsName.length == 0) {
            // 获取系统当前时间
            NSDate * date = [NSDate date];
            NSTimeInterval sec = [date timeIntervalSinceNow];
            NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
            
            //设置时间输出格式：
            NSDateFormatter * df = [[NSDateFormatter alloc] init ];
            [df setDateFormat:@"yyyy年MM月dd日 HH小时mm分ss秒"];
            NSString * curentTIme = [df stringFromDate:currentDate];
            logsName = curentTIme;
        }
        NSData *logData = [logs dataUsingEncoding:NSUTF8StringEncoding];
        DataParser *parser = [[DataParser alloc] initWithData:logData];
        FolderListItem *rootFolder = parser.rootFolder;
        
        KIVArchiverManager *archiveManager = [[KIVArchiverManager alloc] initWithIdentifior:FOLDER_ARTICLE_ARCHIVER_IDENTIFIOR];
        [archiveManager saveLogs:rootFolder keyWord:logsName];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.webStatusLabel.text = [NSString stringWithFormat:@"成功导入书签：%@",logsName];
        });
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.webStatusLabel.text = @"导入失败";
        });
    }
}

@end
