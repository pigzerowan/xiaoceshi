//
//  ProgressPublic.h
//  SmallTaurus
//
//  Created by Fuer on 14-8-5.
//  Copyright (c) 2014年 FuEr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"
#import "MBProgressHUD.h"
@interface ProgressPublic : NSObject
/*
 单例模式的接口，该接口会自动以单例模式创建实例
 */
+(ProgressPublic*) instance;
//SVProgressHUD的
//简单的文字显示
+(void)showSimple:(NSString *)message withDuration:(NSTimeInterval)duration;
//显示网络请求时的错误信息
+(void)showError:(NSError *)error withDuration:(NSTimeInterval)duration;
//定制多少时间内消失，并可以设置转动时可不可以点击

+(void)showMessage:(NSString *)message withDuration:(NSTimeInterval)duration maskType:(SVProgressHUDMaskType)maskType;

@end
