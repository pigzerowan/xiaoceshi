//
//  DMGCURLManager.h
//  GoodChilds
//
//  Created by Quan on 16/7/21.
//  Copyright © 2016年 duanmu. All rights reserved.
//
/**
 *  项目中的URL存放类
 *  利用接口＋参数形式获得Web接口URL，提高代码可阅读性，方法名为WEB的接口名
 */

#import <Foundation/Foundation.h>

@interface DMGCURLManager : NSObject
/*
 单例模式的接口，该接口会自动以单例模式创建实例
 */
+(DMGCURLManager*) provider;
//获取app信息,动态更改启动图时用的
+(NSString *)appInfor;
//验证码
+(NSString *)checkNum;
//报名列表
+(NSString *)enterForList;
//--------------------------------登录、注册----------------------------
//查询用户是否存在，这时是登录时使用的，区别userQuery 这个接口
+(NSString *)queryUser;
//获取短信验证码（注册）,参数：phone（手机号），type（验证类型 1-注册；2-找回密码）
+(NSString *)sendSms;
//注册，参数：phone（手机号），pwd（密码），msgCode（	验证码）
+(NSString *)regist;
//注册协议
+(NSString *)userRule;
//登录
+(NSString *)login;
//找回登录密码
+(NSString *)returnPwd;
//退出登录
+(NSString *)loginout;
+(NSString *)listReg;
// 商品信息
+(NSString *)shopInfor;
// 商品列表
+(NSString *)shopStock;
// 商品详情
+(NSString *)orderDetail;

// 商品详情
+(NSString *)messageList;

@end
