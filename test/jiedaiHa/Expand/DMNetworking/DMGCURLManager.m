//
//  DMGCURLManager.m
//  GoodChilds
//
//  Created by Quan on 16/7/21.
//  Copyright © 2016年 duanmu. All rights reserved.
//

#import "DMGCURLManager.h"
#import "UserSetting.h"
#define domain  [UserSetting provider].DoMain //主域名

@implementation DMGCURLManager

+(DMGCURLManager*) provider
{
    static DMGCURLManager *urlManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        urlManager = [[DMGCURLManager alloc]init];
    });
    return urlManager;

}
+(NSString *)appInfor
{
    return [NSString stringWithFormat:@"%@/api/system/appInfor.do",domain];
}
+(NSString *)enterForList
{
    return [NSString stringWithFormat:@"%@/api/reg/list.do",domain];
}
+(NSString *)queryUser
{
    return [NSString stringWithFormat:@"%@/app/login",domain];
}

+(NSString *)checkNum
{
    return [NSString stringWithFormat:@"%@/app/sms",domain];
}

+(NSString *)login
{
    return [NSString stringWithFormat:@"%@/api/user/login.do",domain];
}
+(NSString *)loginout {
    
    return [NSString stringWithFormat:@"%@/app/logout",domain];

}



+(NSString *)shopInfor {
    
    return [NSString stringWithFormat:@"%@/app/shop/",domain];
}


+(NSString *)listReg
{
    return [NSString stringWithFormat:@"%@/app/shop/orders",domain];
}


+(NSString *)shopStock {
    
    return [NSString stringWithFormat:@"%@/app/shop/stock",domain];

    
}

+(NSString *)orderDetail {
    
    return [NSString stringWithFormat:@"%@/app/shop/order/",domain];
}

+(NSString *)messageList {
    
    return [NSString stringWithFormat:@"%@",@"https://3evjrl4n5d.execute-api.us-west-1.amazonaws.com/dev/message"];
}


//+(NSString *)queryUser
//{
//    return [NSString stringWithFormat:@"%@/app/login",domain];
//}



@end
