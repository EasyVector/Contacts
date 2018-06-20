//
//  SiteViewController.m
//  Contacts
//
//  Created by 苏宇辉 on 2018/6/19.
//  Copyright © 2018年 苏宇辉. All rights reserved.
//

#import "SiteViewController.h"

@interface SiteViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
{
    WKUserContentController* userContentController;
    UIWebView *webView;
}
@end


@implementation SiteViewController

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)viewDidLoad {
    [super viewDidLoad];
//    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
//    [_web loadRequest:[NSURLRequest requestWithURL: url]];
//    [self.view addSubview:_web];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,width,height)];
    // 2.创建URL
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    // 3.创建Request
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    // 4.加载网页
    [webView loadRequest:request];
    // 5.最后将webView添加到界面
    [self.view addSubview:webView];
    self->webView = webView;
    webView.delegate = self;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    //显示网络请求加载
    [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"系统提示"
                                                    message:@"网络连接发生错误!"
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"确定", nil];
    [alert show];
}

@end
