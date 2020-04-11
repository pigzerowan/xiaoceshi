//
//  AsteriskTool.m
//  GoodChilds
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 duanmu. All rights reserved.
//

#import "AsteriskTool.h"

@implementation AsteriskTool
+(NSString*)versionToInt:(NSString*)versionString
{
    return [versionString stringByReplacingOccurrencesOfString:@"." withString:@""];
}

+(NSString *)phoneNumToAsterisk:(NSString*)phoneNum
{
    return phoneNum.length>=5?[phoneNum stringByReplacingCharactersInRange:NSMakeRange(3,4) withString:@"****"]:phoneNum;
}

+(NSString *)phoneNumAddblank:(NSString*)phoneNum
{
    NSString * outputString = @"";
    for (int i =0; i<[phoneNum length]; i++) {
        
        if (i == 3|| i == 7) {
            outputString = [outputString stringByAppendingString:[NSString stringWithFormat:@"%@%c",@" ",[phoneNum characterAtIndex:i]]];
        }else{
            outputString = [outputString stringByAppendingString:[NSString stringWithFormat:@"%c",[phoneNum characterAtIndex:i]]];
        }
    }
    return outputString;
    
}
+(NSString *)idNameToAsterisk:(NSString *)name
{
    return name.length>=1?[name stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"*"]:name;
}
+(NSString*)idCardToAsterisk:(NSString *)idCardNum
{
    return idCardNum.length>=10?[idCardNum stringByReplacingCharactersInRange:NSMakeRange(4, idCardNum.length -8) withString:@"*******"]:idCardNum;
}

@end
