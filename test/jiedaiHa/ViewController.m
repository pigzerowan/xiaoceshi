//
//  ViewController.m
//  jiedaiHa
//
//  Created by 郑渊文 on 2017/6/20.
//  Copyright © 2017年 transfar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    _myWebView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    _myWebView.delegate =self;
    
    
    NSString *str = [NSString stringWithFormat:@"https://mdaikuan.2345.com/static/register/register.html?channel=cpl_13248400912"];
    
    
    NSString *strmy = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:strmy];
    //NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSMutableURLRequest *request =   [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
    
    //    //    //从请求中获取缓存输出
    //    NSCachedURLResponse *response =[self.urlCache cachedResponseForRequest:request];
    //    //判断是否有缓存
    //    if (response != nil){
    //        NSLog(@"如果有缓存输出，从缓存中获取数据");
    //        [request setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
    //    }
    //
    
    [_myWebView loadRequest:request];
    
    _myWebView.delegate =self;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_myWebView];
    
    

    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
