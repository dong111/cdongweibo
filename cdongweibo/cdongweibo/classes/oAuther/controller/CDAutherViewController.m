//
//  CDAutherViewController.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/16.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDAutherViewController.h"
#import "CDUitiity.h"
#import "AFNetworking.h"
#import "MBProgressHUD+CD.h"
#import "CDUser.h"
#import "CDUserService.h"
#import "CDRootService.h"

@interface CDAutherViewController () <UIWebViewDelegate>

@end

@implementation CDAutherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    //构造请求: https://api.weibo.com/oauth2/authorize?client_id=2355429710&redirect_uri=http://www.baidu.com
    NSString *url =[NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",CD_AUTHORIZE_URL,CD_CLIENT_ID,CD_REDIRECT_URL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    webView.delegate = self;
    
    [webView loadRequest:request];
    
}




#pragma mark webView代理方法
//在视图加载前  return yes 加载视图 否则不加载
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
//    NSLog(@"%@",request.URL.absoluteString);
    //获取用户登录后 重定向地址所带的参数code
    NSString *url = request.URL.absoluteString;
    NSRange codeRange = [url rangeOfString:@"code="];
//    NSLog(@"loaction:-->%ld,length-->%ld",codeRange.location,codeRange.length);
    
    if (codeRange.length) {//获取到了code
        //截取code
        NSString *code = [url substringFromIndex:(codeRange.location+codeRange.length)];
         // 换取accessToken
//        NSLog(@"%@",code);
        [self accessCodeWithCode:code];
        return NO;
    }
    
    
    return YES;
}

//换取accessToken
- (void) accessCodeWithCode:(NSString *)code
{
    [CDUserService accessCodeWithCode:code success:^{
        //跳转到选择跟控制器
        [CDRootService chooseRootView:CDKeyWindow];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
//网页开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //提示用户加载
    [MBProgressHUD showMessage:@"正在加载……"];
}
//网页完成加载
- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}
//网页加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
     [MBProgressHUD hideHUD];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
