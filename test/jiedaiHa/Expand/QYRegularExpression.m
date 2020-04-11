//
//  QYRegularExpression.m
//  SmallTaurus
//
//  Created by Fuer on 14-7-9.
//  Copyright (c) 2014年 FuEr. All rights reserved.
//

#import "QYRegularExpression.h"

@implementation QYRegularExpression
+ (BOOL)isValidateEmail:(NSString *)string
{
    NSString *regex = @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

+ (BOOL)isNumber:(NSString *)string
{
    NSString *regex = @"^[0-9]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

+ (BOOL)isEnglishWords:(NSString *)string
{
    NSString *regex = @"^[A-Za-z]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

//字母数字，6－20位
+ (BOOL)isValidatePassword:(NSString *)string
{
    NSString *regex = @"^[a-zA-Z0-9]{6,16}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}
+ (BOOL)isvalidatepassword2:(NSString *)string
{
    NSString *regex = @"^((?!\\d+$)(?![a-zA-Z]+$)[a-zA-Z\\d@#$%^&_+].{6,})+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}
+ (BOOL)isValidatePassword3:(NSString *)string
{
    //@"^(?![^a-zA-Z]+$)(?!\\D+$)[0-9a-zA-Z]{6,16}$"
    NSString *regex = @"^(?!([a-zA-Z]+|\\d+)$)[a-zA-Z\\d]{6,16}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}
+ (BOOL)isValidateNickName:(NSString *)nickNameString
{
    NSString *regex = @"^[0-9a-zA-Z\u4e00-\u9fa5]{4,24}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:nickNameString];

}
+ (BOOL)isChineseWords:(NSString *)string
{
    NSString *regex = @"^[\u4e00-\u9fa5],{0,}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

+ (BOOL)isInternetUrl:(NSString *)string
{
    NSString *regex = @"^http://([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?$ ；^[a-zA-z]+://(w+(-w+)*)(.(w+(-w+)*))*(?S*)?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

+ (BOOL)isPhoneNumber:(NSString *)string
{
    //NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0-9])|(17[0-9]))\\d{8}$";
    NSString *phoneRegex = @"^((1[0-9][0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:string];
}

+ (BOOL)isElevenDigitNum:(NSString *)string
{
    NSString *regex = @"^[0-9]*$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL result = [predicate evaluateWithObject:string];
    
    if (result && string.length == 11)
        return YES;
    
    return NO;
}

+ (BOOL)isIdentifyCardNumber:(NSString *)string
{
    BOOL flag;
    if (string.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:string];
}
+(BOOL)isMoneyStart0:(NSString*)string
{
    NSString *regex = @"^[1-9]\\d*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [predicate evaluateWithObject:string];
    
}
+(BOOL)isTwoPoint:(NSString *)string
{
    NSString *regex = @"^[0-9]+(.[0-9]{1,2})?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}
+(BOOL)is100IntegerMultiples:(NSString*)string
{
    NSString *regex = @"^[1-9]\\d*0{2}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [predicate evaluateWithObject:string];
}
+(BOOL)isHttpErroCode:(NSString *)string
{
    NSString *regex = @"^(50[0-9]|5[0-9]\\d)$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [predicate evaluateWithObject:string];

}
@end
