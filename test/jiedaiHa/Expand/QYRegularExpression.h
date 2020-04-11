//
//  QYRegularExpression.h
//  SmallTaurus
//
//  Created by Fuer on 14-7-9.
//  Copyright (c) 2014年 FuEr. All rights reserved.
//
/**
 *  常用的一些正则表达
 */
#import <Foundation/Foundation.h>

@interface QYRegularExpression : NSObject
+ (BOOL)isValidateEmail:(NSString *)email;//邮箱符合性验证。
+ (BOOL)isNumber:(NSString *)string;//全是数字。
+ (BOOL)isEnglishWords:(NSString *)string;//验证英文字母。
+ (BOOL)isValidatePassword:(NSString *)string;//验证密码：6—20位，只能包含字符、数字。
+ (BOOL)isvalidatepassword2:(NSString *)string;//验证密码：6位以上数字+字母+字符 或 字母+字符 或 数字+字母 或 数字+字符。
+ (BOOL)isValidatePassword3:(NSString *)string;//验证密码：6—20位，只能包含字符、数字。

+ (BOOL)isValidateNickName:(NSString *)nickString;//4—24位，只能包含字母、数字和 汉字。
+ (BOOL)isChineseWords:(NSString *)string;//验证是否为汉字。
+ (BOOL)isInternetUrl:(NSString *)string;//验证是否为网络链接。

//正确格式为：XXXX-XXXXXXX，XXXX-XXXXXXXX，XXX-XXXXXXX，XXX-XXXXXXXX，XXXXXXX，XXXXXXXX
+ (BOOL)isPhoneNumber:(NSString *)string;//验证是否为电话号码。
+ (BOOL)isElevenDigitNum:(NSString *)string;
+ (BOOL)isIdentifyCardNumber:(NSString *)string;//验证15或18位身份证。

//不能输入以0开头的整数
+(BOOL)isMoneyStart0:(NSString*)string;
+(BOOL)isTwoPoint:(NSString *)string;
+(BOOL)is100IntegerMultiples:(NSString*)string;//100的整数倍
//400-499 、500-599之间的正则
+(BOOL)isHttpErroCode:(NSString *)string;
@end
