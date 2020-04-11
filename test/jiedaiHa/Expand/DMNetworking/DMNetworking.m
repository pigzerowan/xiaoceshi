//
//  DMNetworking.m
//  PPJiJin
//
//  Created by Quan on 16/6/5.
//  Copyright © 2016年 Sany. All rights reserved.
//

#import "DMNetworking.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "MBProgressHUD.h"
#import "UserSetting.h"
#import "AppDelegate.h"
static NSTimeInterval m_timeout = 50.0f;
static NSDictionary *m_httpHeaders = nil;
static NSMutableArray *tasks;

@implementation DMNetworking
+ (DMNetworking *)shareDMNetworking{
    static DMNetworking *dmNetworking = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dmNetworking = [[DMNetworking alloc] init];
    });
    return dmNetworking;
}
+(NSMutableArray *)tasks{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       //创建tasks数组
        tasks = [[NSMutableArray alloc] init];
    });
    return tasks;
}
+ (void)setTimeout:(NSTimeInterval)timeout
{
    m_timeout = timeout;
}
+ (void)commonHttpHeaders:(NSDictionary *)httpHeaders {
    m_httpHeaders = httpHeaders;
}

+(AFHTTPSessionManager *)getAFManager{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = manager = [AFHTTPSessionManager manager];
    
    AFJSONRequestSerializer *rqSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:0];//NSJSONWritingPrettyPrinted
    
    rqSerializer.stringEncoding = NSUTF8StringEncoding;
    
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
    
    manager.requestSerializer = requestSerializer;//设置请求数据为json
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//设置返回数据为json
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
   
   
    manager.requestSerializer.timeoutInterval=m_timeout;
    for (NSString *key in m_httpHeaders.allKeys) {
        if (m_httpHeaders[key] != nil) {
            [manager.requestSerializer setValue:m_httpHeaders[key] forHTTPHeaderField:key];
            // NSLog(@"---manager-:key--:%@,values--:%@",key,m_httpHeaders[key]);
        }
    }
    
    //https认证
//    manager.securityPolicy.allowInvalidCertificates = YES;
//    manager.securityPolicy = [self customSecurityPolicy];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*",
                                                                              @"charset=UTF-8"]];
    
    return manager;
    
}

+(DMURLSessionTask *)getWithUrl:(NSString *)url
                         params:(NSDictionary *)params
                        success:(DMResponseSuccess)success
                           fail:(DMResponseFail)fail
                        showHUD:(BOOL)showHUD{
    
    return [self baseRequestType:DMNetworkGet url:url params:params success:success fail:fail showHUD:showHUD];
}

+(DMURLSessionTask *)postWithUrl:(NSString *)url
                          params:(NSDictionary *)params
                         success:(DMResponseSuccess)success
                            fail:(DMResponseFail)fail
                         showHUD:(BOOL)showHUD{
    return [self baseRequestType:DMNetworkPost url:url params:params success:success fail:fail showHUD:showHUD];
}

+(DMURLSessionTask *)baseRequestType:(NSUInteger)type
                                 url:(NSString *)url
                              params:(NSDictionary *)params
                             success:(DMResponseSuccess)success
                                fail:(DMResponseFail)fail
                             showHUD:(BOOL)showHUD{

    if (url==nil) {
        return nil;
    }

    NSString *urlStr=[NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
    
    //初始化AFHTTPSessionManager
    AFHTTPSessionManager *manager=[self getAFManager];

     DMURLSessionTask *sessionTask=nil;
    
    if (type==1){
        sessionTask = [manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject[@"data"]);
            }
            
            [[self tasks] removeObject:sessionTask];

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (fail) {
                fail(error);
            }
            
            [[self tasks] removeObject:sessionTask];


        }];
        
    }else{
        
        sessionTask = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
            if (success){
                success(responseObject);
            }
            
            [[self tasks] removeObject:sessionTask];
            
          //  if (showHUD==YES){
            //    [MBProgressHUD hideHUDForView:selectVC.view animated:YES];
//}
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (fail){
                fail(error);
            }
            
            [[self tasks] removeObject:sessionTask];
            
          //  if (showHUD==YES){
             //   [MBProgressHUD hideHUDForView:selectVC.view animated:YES];
           // }
        }];
    }
    
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    
    return sessionTask;
    
}
+ (DMURLSessionTask *)uploadWithImage:(UIImage *)image
                                  url:(NSString *)url
                             filename:(NSString *)filename
                                 name:(NSString *)name
                               params:(NSDictionary *)params
                             progress:(DMUploadProgress)progress
                              success:(DMResponseSuccess)success
                                 fail:(DMResponseFail)fail
                              showHUD:(BOOL)showHUD{
    if (url==nil) {
        return nil;
    }
    
    if (showHUD==YES) {
        //[MBProgressHUD showHUD];
    }
    
    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
    
    AFHTTPSessionManager *manager=[self getAFManager];
    
    DMURLSessionTask *sessionTask = [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //压缩图片
        NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
        
        NSString *imageFileName = filename;
        if (filename == nil || ![filename isKindOfClass:[NSString class]] || filename.length == 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            imageFileName = [NSString stringWithFormat:@"%@.png", str];
        }
        
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:@"image/jpg/png/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
        [[self tasks] removeObject:sessionTask];
        
        if (showHUD==YES) {
            //[MBProgressHUD dissmiss];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        if (fail) {
            fail(error);
        }
        
        [[self tasks] removeObject:sessionTask];
        
        if (showHUD==YES) {
            //[MBProgressHUD dissmiss];
        }
        
    }];
    
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    
    return sessionTask;

}
+ (DMURLSessionTask *)uploadWithImages:(NSArray *)imageArr
                                   url:(NSString *)url
                              filename:(NSString *)filename
                                  name:(NSString *)name
                                params:(NSDictionary *)params
                              progress:(DMUploadProgress)progress
                               success:(DMResponseSuccess)success
                                  fail:(DMResponseFail)fail
                               showHUD:(BOOL)showHUD{
    
    if (url==nil) {
        return nil;
    }
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   // DMBaseViewController *selectVC = appDelegate.m_tabBarController.selectedViewController;
   // if (showHUD==YES) {
    //     [MBProgressHUD showHUDAddedTo:selectVC.view animated:YES];
   // }
    
    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
    
    AFHTTPSessionManager *manager=[self getAFManager];
    
    DMURLSessionTask *sessionTask = [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        for (int i = 0; i< imageArr.count; i++) {
            //压缩图片
            NSData * imageData = UIImageJPEGRepresentation(imageArr[i], 0.7);
             NSLog(@"upload image size: %ld k", (long)(imageData.length / 1024));
            NSString *imageFileName = filename;
            if (filename == nil || ![filename isKindOfClass:[NSString class]] || filename.length == 0) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                //NSLog(@"======:%@",str);
                imageFileName = [NSString stringWithFormat:@"%@.png", str];
                // 上传图片，以文件流的格式
                NSString *m_fileStr = [NSString stringWithFormat:@"file%d",i];
                [formData appendPartWithFileData:imageData name:m_fileStr fileName:imageFileName mimeType:@"image/jpg/png/jpeg"];
            }
            
           
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
        [[self tasks] removeObject:sessionTask];
        
       // if (showHUD==YES) {
         //   [MBProgressHUD hideHUDForView:selectVC.view animated:YES];
      //  }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (fail) {
            fail(error);
        }
        
        [[self tasks] removeObject:sessionTask];
        
       // if (showHUD==YES) {
         //   [MBProgressHUD hideHUDForView:selectVC.view animated:YES];
       // }
        
    }];
    
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    
    return sessionTask;

    
    
    
    
    


}
+ (DMURLSessionTask *)downloadWithUrl:(NSString *)url
                           saveToPath:(NSString *)saveToPath
                             progress:(DMDownloadProgress )progressBlock
                              success:(DMResponseSuccess )success
                              failure:(DMResponseFail )fail
                              showHUD:(BOOL)showHUD{
    if (url==nil) {
        return nil;
    }
    
    if (showHUD==YES) {
       // [MBProgressHUD showHUD];
    }
    
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPSessionManager *manager = [self getAFManager];
    
    DMURLSessionTask *sessionTask = nil;
    
    sessionTask = [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        //回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progressBlock) {
                progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        if (!saveToPath) {
            
            NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            //默认路径--downloadURL;
            return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
            
        }else{
            return [NSURL fileURLWithPath:saveToPath];
            
        }
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        [[self tasks] removeObject:sessionTask];
        
        if (error == nil) {
            if (success) {
                success([filePath path]);//返回完整路径
            }
            
        }else {
            if (fail) {
                fail(error);
            }
        }
        
        if (showHUD==YES) {
           // [MBProgressHUD dissmiss];
        }
        
    }];
    
    //开始启动任务
    [sessionTask resume];
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    
    return sessionTask;
}
+ (void)cancelAllRequest{
    @synchronized(self) {
        [[self tasks] enumerateObjectsUsingBlock:^(DMURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[DMURLSessionTask class]]) {
                [task cancel];
            }
        }];
        
        [[self tasks] removeAllObjects];
    };
}
+ (void)cancelRequestWithURL:(NSString *)url{
    if (url == nil) {
        return;
    }
    @synchronized(self) {
        [[self tasks] enumerateObjectsUsingBlock:^(DMURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[DMURLSessionTask class]]
                && [task.currentRequest.URL.absoluteString hasSuffix:url]) {
                [task cancel];
                [[self tasks] removeObject:task];
                return;
            }
        }];
    };

}
#pragma makr - 开始监听网络连接
+ (void)startMonitoring{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *netReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [netReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status){
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                
                [DMNetworking shareDMNetworking].networkStats=DMNetworkStatusUnknown;
                
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                
                [DMNetworking shareDMNetworking].networkStats=DMNetworkStatusNotReachable;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                
                [DMNetworking shareDMNetworking].networkStats=DMNetworkStatusReachableViaWWAN;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                
                [DMNetworking shareDMNetworking].networkStats=DMNetworkStatusReachableViaWiFi;
                
                break;
        }
    }];
    [netReachabilityManager startMonitoring];
}

+(NSString *)strUTF8Encoding:(NSString *)str{
    //return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - https认证
+ (AFSecurityPolicy*)customSecurityPolicy
{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"xxx" ofType:@"cer"]; //证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = YES;
    NSSet * set = [NSSet setWithObject:certData];
    securityPolicy.pinnedCertificates = set;
    
    return securityPolicy;
}


// 获取当前处于activity状态的view controller
- (UIViewController *)activityViewController
{
    UIViewController* activityViewController = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows)
        {
            if(tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0)
    {
        UIView *frontView = [viewsArray objectAtIndex:0];
        
        id nextResponder = [frontView nextResponder];
        
        if([nextResponder isKindOfClass:[UIViewController class]])
        {
            activityViewController = nextResponder;
        }
        else
        {
            activityViewController = window.rootViewController;
        }
    }
    
    return activityViewController;
}

@end
