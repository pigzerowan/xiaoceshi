//
//  UserSetting.h
//  GoodChilds
//
//  Created by apple on 16/7/21.
//  Copyright © 2016年 duanmu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSetting : NSObject
@property(nonatomic,strong)NSString *Code;//随机生成10位数字
@property(nonatomic,strong)NSString *Token;//token
@property(nonatomic,strong)NSString *PhoneNum;//手机号
@property(nonatomic,strong)NSString *PhoneNumOmit;//省略生的手机号（151****99）
@property(nonatomic,strong)NSString *PhotoUrl;//头像
@property(nonatomic,strong)NSString *DoMain;//请求头文件
@property(nonatomic,strong)NSString *Version;//app版本信息

@property(nonatomic,strong)NSString *UserName;//姓名
@property(nonatomic,strong)NSString *Gender;//性别
@property(nonatomic,strong)NSString *IdentityCard;//身份证号
@property(nonatomic,strong)NSString *IdTag;//用于保存有没有绑定过身份证号
@property(nonatomic,strong)NSString *School;//学校
@property(nonatomic,strong)NSString *Mail;//mail
@property(nonatomic,strong)NSString *Participate;//参赛
@property(nonatomic,strong)NSString *BaomingTag;//表示报名没有成功

//2016.11.11
@property(nonatomic,strong)NSString *FansNum;//粉丝数
@property(nonatomic,strong)NSString *FollowNum;//关注数
@property(nonatomic,strong)NSString *ImgNum;//图片数

@property(nonatomic,strong)NSString *serverVersion;//服务器版本号

@property(nonatomic,strong)NSString *LEVELID;

@property(nonatomic,strong)NSString *POINTS;//积分
@property(nonatomic,strong)NSString *USER_LEVEL;//用户等级
/*
 单例模式的接口，该接口会自动以单例模式创建实例
 */
+(UserSetting*)provider;
/*
 存盘帐号信息
 */
-(void) saveAccount;
/**
 *  判断用户的token是是否存在，用来检测用户有没有登录
 *
 */
-(BOOL)checkLogin;
//微信KEY
-(NSString*)WeiXinKEY;
//微信URL 定制类型
-(NSString*) wxURLScheme;
//支付宝URL 定制类型
-(NSString*)alipayURLScheme;

@end
