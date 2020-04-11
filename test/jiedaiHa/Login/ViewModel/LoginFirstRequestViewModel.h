//
//  LoginFirstRequestViewModel.h
//  GoodChilds
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 duanmu. All rights reserved.
//
/**
 *  登录第一个页面的request ViewModel
 */
#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger,QueryLoginRequestResult) {
    DMRegistered = 1, //已经注册
    DMNoRegistered = 2,//没有注册

} ;
@class LoginViewController;

@interface LoginFirstRequestViewModel : NSObject
@property (nonatomic, strong) NSString *phoneNum;
@property (nonatomic, strong) RACSignal *requestSignal; ///< 网络请求信号量
@end
