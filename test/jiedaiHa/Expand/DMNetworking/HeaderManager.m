//
//  HeaderManager.m
//  GoodChilds
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 duanmu. All rights reserved.
//

#import "HeaderManager.h"
#import "DMNetworking.h"
#import "UserSetting.h"
@implementation HeaderManager
+(void)updateHeader
{
    NSMutableDictionary *tokenHeader = [[NSMutableDictionary alloc] init];
    if([UserSetting provider].Token)
        [tokenHeader setValue:[UserSetting provider].Token forKey:@"token"];
    if([UserSetting provider].Code)
        [tokenHeader setValue:[UserSetting provider].Code forKey:@"code"];
    
    [tokenHeader setValue:@"30" forKey:@"channel"];//渠道
    [tokenHeader setValue:@"1" forKey:@"terminal"];//终端
    [UserSetting provider].Version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [tokenHeader setValue:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] forKey:@"version"];
    [tokenHeader setValue:[[UIDevice currentDevice] systemVersion] forKey:@"sysversion"];
    
    [DMNetworking commonHttpHeaders:tokenHeader];
    
}


@end
