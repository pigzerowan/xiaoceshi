//
//  AsteriskTool.h
//  GoodChilds
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 duanmu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AsteriskTool : NSObject
+(NSString*)versionToInt:(NSString*)versionString;
//把手机号第4-8位变成星号
+(NSString *)phoneNumToAsterisk:(NSString*)phoneNum;
+(NSString *)phoneNumAddblank:(NSString*)phoneNum;
//把名字前2位变成星号
+(NSString *)idNameToAsterisk:(NSString *)name;
//把身体证第5-15位变成星号
+(NSString *)idCardToAsterisk:(NSString *)idCardNum;
@end

