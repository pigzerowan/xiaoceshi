//
//  UserSetting.m
//  GoodChilds
//
//  Created by apple on 16/7/21.
//  Copyright © 2016年 duanmu. All rights reserved.
//

#import "UserSetting.h"

@implementation UserSetting
+(UserSetting*)provider
{
    static UserSetting *userSetting = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userSetting  = [[UserSetting alloc]init];
        [userSetting loadAccount];
    });
    return  userSetting;
}
//读取帐号信息
-(void)loadAccount
{
    self.Token =  [[NSUserDefaults standardUserDefaults] objectForKey:@"Token"] ;
    self.Code = [[NSUserDefaults standardUserDefaults] objectForKey:@"Code"] ;
    self.PhoneNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"PhoneNum"] ;
    self.IdTag = [[NSUserDefaults standardUserDefaults] objectForKey:@"IdTag"] ;
}
-(void) saveAccount
{
    [[NSUserDefaults standardUserDefaults] setObject:[self ppHandleNull:self.Token] forKey:@"Token"];
    [[NSUserDefaults standardUserDefaults] setObject:[self ppHandleNull:self.Code] forKey:@"Code"];
    [[NSUserDefaults standardUserDefaults] setObject:[self ppHandleNull:self.PhoneNum] forKey:@"PhoneNum"];
    [[NSUserDefaults standardUserDefaults] setObject:[self ppHandleNull:self.IdTag] forKey:@"IdTag"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
-(NSString *)ppHandleNull:(NSString *)strValue
{
    if (strValue == nil || [strValue isEqual:[NSNull null]]) {
        // handle the place not being available
        strValue = @"";
    }
    return strValue;
}
-(BOOL)checkLogin
{
    return (self.Token!=nil && self.Token.length!=0);
}
-(NSString*)WeiXinKEY
{
    NSString* registerAppId= nil;
    NSArray* array = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
    for (NSDictionary* dictItem in array)
    {
        NSString* urlName = [dictItem objectForKey:@"CFBundleURLName"];
        
        if ([urlName isEqualToString:@"com.weixin"])
        {
            NSArray* schemeArray = [dictItem objectForKey:@"CFBundleURLSchemes"];
            
            if ([schemeArray count] > 0)
            {
                registerAppId = [schemeArray objectAtIndex:0];
            }
        }
    }
    return registerAppId;
}
-(NSString*)wxURLScheme
{
    NSArray * arrURLTypes = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleURLTypes"];
    NSArray * arrURLSchems= [[arrURLTypes objectAtIndex:0] objectForKey:@"CFBundleURLSchemes"];
    return [arrURLSchems objectAtIndex:0];
}
-(NSString*)alipayURLScheme
{
    NSArray * arrURLTypes = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleURLTypes" ];
    NSArray * arrURLSchems= [[arrURLTypes objectAtIndex:1] objectForKey:@"CFBundleURLSchemes" ];
    return [arrURLSchems objectAtIndex:0];
}

@end
