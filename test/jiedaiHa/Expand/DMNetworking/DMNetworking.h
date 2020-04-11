//
//  DMNetworking.h
//  PPJiJin
//
//  Created by Quan on 16/6/5.
//  Copyright © 2016年 Sany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,DMNetworkMethod) {
    DMNetworkGet = 1,
    DMNetworkPost = 2,
};
//网络状态
typedef NS_ENUM(NSInteger, DMNetworkStatus) {
    DMNetworkStatusUnknown          = -1,//未知网络
    DMNetworkStatusNotReachable     = 0,//网络无连接
    DMNetworkStatusReachableViaWWAN = 1,//2，3，4G网络
    DMNetworkStatusReachableViaWiFi = 2,//WIFI网络
};


/**
 *  方便管理请求任务。执行取消，暂停，继续等任务.
 *  - (void)cancel，取消任务
 *  - (void)suspend，暂停任务
 *  - (void)resume，继续任务
 */
@class NSURLSessionTask;

typedef NSURLSessionTask DMURLSessionTask;

/**
 *  返回成功block
 *
 *  @param response 成功
 */
typedef void(^DMResponseSuccess)(id response);
/**
 *  返回失败block
 *
 *  @param error 失败
 */
typedef void(^DMResponseFail)(NSError *error);


/**
 *  下载进度
 *
 *  @param bytesRead                 已下载的大小
 *  @param totalBytesRead            文件总大小
 *  @param totalBytesExpectedToRead 还有多少需要下载
 */
typedef void (^DMDownloadProgress)(int64_t bytesRead,
                                    int64_t totalBytesRead);

/**
 *  上传进度
 *
 *  @param bytesWritten              已上传的大小
 *  @param totalBytesWritten         总上传大小
 */
typedef void (^DMUploadProgress)(int64_t bytesWritten,
                                  int64_t totalBytesWritten);


@interface DMNetworking : NSObject
/**
 *  单例
 *
 *  @return
 */
+ (DMNetworking *)shareDMNetworking;

/**
 *  获取网络状态
 */
@property (nonatomic,assign)DMNetworkStatus networkStats;
/**
 *	设置请求超时时间，默认为50秒,HYBNetworking
 *
 *	@param timeout 超时时间
 */
+ (void)setTimeout:(NSTimeInterval)timeout;
/**
 *
 *  配置公共的请求头，只调用一次即可，通常放在应用启动的时候配置就可以了
 *
 *  @param httpHeaders 只需要将与服务器商定的固定参数设置即可
 */
+ (void)commonHttpHeaders:(NSDictionary *)httpHeaders;
/**
 *  开启网络监测
 */
+ (void)startMonitoring;

/**
 *
 *	取消所有请求
 */
+ (void)cancelAllRequest;
/**
 *
 *	取消某个请求。如果是要取消某个请求，最好是引用接口所返回来的DMURLSessionTask对象，
 *  然后调用对象的cancel方法。如果不想引用对象，这里额外提供了一种方法来实现取消某个请求
 *
 *	@param url	URL，可以是绝对URL，也可以是path（也就是不包括baseurl）
 */
+ (void)cancelRequestWithURL:(NSString *)url;


/**
 *  get请求方法,block回调
 *
 *  @param url     请求连接，根路径
 *  @param params  参数
 *  @param success 请求成功返回数据
 *  @param fail    请求失败
 *  @param showHUD 是否显示HUD
 */
+(DMURLSessionTask *)getWithUrl:(NSString *)url
                         params:(NSDictionary *)params
                        success:(DMResponseSuccess)success
                           fail:(DMResponseFail)fail
                        showHUD:(BOOL)showHUD;
/**
 *  post请求方法,block回调
 *
 *  @param url     请求连接，根路径
 *  @param params  参数
 *  @param success 请求成功返回数据
 *  @param fail    请求失败
 *  @param showHUD 是否显示HUD
 */
+(DMURLSessionTask *)postWithUrl:(NSString *)url
                          params:(NSDictionary *)params
                         success:(DMResponseSuccess)success
                            fail:(DMResponseFail)fail
                         showHUD:(BOOL)showHUD;

/**
 *  上传图片方法
 *
 *  @param image      上传的图片
 *  @param url        请求连接，根路径
 *  @param filename   图片的名称(如果不传则以当时间命名)
 *  @param name       上传图片时填写的图片对应的参数
 *  @param params     参数
 *  @param progress   上传进度
 *  @param success    请求成功返回数据
 *  @param fail       请求失败
 *  @param showHUD    是否显示HUD
 */
+ (DMURLSessionTask *)uploadWithImage:(UIImage *)image
                                  url:(NSString *)url
                             filename:(NSString *)filename
                                 name:(NSString *)name
                               params:(NSDictionary *)params
                             progress:(DMUploadProgress)progress
                              success:(DMResponseSuccess)success
                                 fail:(DMResponseFail)fail
                              showHUD:(BOOL)showHUD;

/**
 *  上传多张图片方法
 *
 *  @param image      上传的图片
 *  @param url        请求连接，根路径
 *  @param filename   图片的名称(如果不传则以当时间命名)
 *  @param name       上传图片时填写的图片对应的参数
 *  @param params     参数
 *  @param progress   上传进度
 *  @param success    请求成功返回数据
 *  @param fail       请求失败
 *  @param showHUD    是否显示HUD
 */
+ (DMURLSessionTask *)uploadWithImages:(NSArray *)imageArr
                                  url:(NSString *)url
                             filename:(NSString *)filename
                                 name:(NSString *)name
                               params:(NSDictionary *)params
                             progress:(DMUploadProgress)progress
                              success:(DMResponseSuccess)success
                                 fail:(DMResponseFail)fail
                              showHUD:(BOOL)showHUD;


/**
 *  下载文件方法
 *
 *  @param url           下载地址
 *  @param saveToPath    文件保存的路径,如果不传则保存到Documents目录下，以文件本来的名字命名
 *  @param progressBlock 下载进度回调
 *  @param success       下载完成
 *  @param fail          失败
 *  @param showHUD       是否显示HUD
 *  @return 返回请求任务对象，便于操作
 */
+ (DMURLSessionTask *)downloadWithUrl:(NSString *)url
                           saveToPath:(NSString *)saveToPath
                             progress:(DMDownloadProgress )progressBlock
                              success:(DMResponseSuccess )success
                              failure:(DMResponseFail )fail
                              showHUD:(BOOL)showHUD;
/**
 *  showHUD这里还要判断是放在VC、keywindow还是nav上的，还需要增加缓存功能
 */

@end
