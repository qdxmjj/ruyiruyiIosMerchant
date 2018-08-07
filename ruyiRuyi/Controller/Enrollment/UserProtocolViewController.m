//
//  UserProtocolViewController.m
//  ruyiruyiios
//
//  Created by xujunquan on 2018/5/14.
//  Copyright © 2018年 ruyiruyi. All rights reserved.
//

#import "UserProtocolViewController.h"
@interface UserProtocolViewController ()<UIWebViewDelegate>

@property(nonatomic, strong)UIWebView *mainWebV;

@end

@implementation UserProtocolViewController
@synthesize dealIdStr;


- (UIWebView *)mainWebV{
    
    if (_mainWebV == nil) {
        
        _mainWebV = [[UIWebView alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 40, SCREEN_HEIGHT - bottom_height)];
        _mainWebV.delegate = self;
        _mainWebV.clipsToBounds = NO;
    }
    return _mainWebV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"用户协议";
    [self.view addSubview:self.mainWebV];
    [self getDeal:dealIdStr];
    // Do any additional setup after loading the view.
}

- (void)getDeal:(NSString *)dealStr{
    
    [MBProgressHUD showWaitMessage:@"正在加载..." showView:self.view];
    
    NSDictionary *dealPostDic = @{@"dealId":dealStr};
    
    [JJRequest postRequest:@"getDeal" params:@{@"reqJson":[JJTools convertToJsonData:dealPostDic], @"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@", code];
        NSString *messageStr = [NSString stringWithFormat:@"%@", message];
        if ([statusStr isEqualToString:@"1"]) {
            
            [self analySize:data];
        }else{
            
            [MBProgressHUD showTextMessage:messageStr];
        }
    } failure:^(NSError * _Nullable error) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
        NSLog(@"获取协议错误:%@", error);
    }];
}

- (void)analySize:(NSDictionary *)dataDic{
    
    NSString *contentStr = [self htmlEntityDecode:[dataDic objectForKey:@"content"]];
    [self.mainWebV loadHTMLString:contentStr baseURL:nil];
}

//将 &lt 等类似的字符转化为HTML中的“<”等
- (NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]; // Do this last so that, e.g. @"&amp;lt;" goes to @"&lt;" not @"<"
    
    return string;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [MBProgressHUD hideWaitViewAnimated:self.view];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [MBProgressHUD hideWaitViewAnimated:self.view];
    [MBProgressHUD showTextMessage:@"加载失败"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
