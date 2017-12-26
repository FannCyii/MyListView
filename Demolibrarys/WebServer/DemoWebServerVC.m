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
        NSData *aData = [logs dataUsingEncoding:NSUTF8StringEncoding];
        DataParser *parser = [[DataParser alloc] initWithData:aData];
        FolderListItem *rootFolder = parser.rootFolder;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:rootFolder];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:FOLDER_ARTICLE_ARCHIVER_IDENTIFIOR];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.webStatusLabel.text = @"导入成功";
        });
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.webStatusLabel.text = @"导入失败";
        });
    }
}

@end
