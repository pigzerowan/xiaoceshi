//
//  LoginManager.h
//  PPJiJin
//
//  Created by Sany on 15/3/25.
//  Copyright (c) 2015年 Sany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMDefine.h"

typedef void(^LoginCompletionBlock)(LoginObjectResult11 LoginResult);
@interface LoginManager : NSObject



+(LoginManager*)provider;

 //弹出登录界面，完成后回调
-(void)showLogin:(UIViewController *)inViewController completion:LoginCompletionBlock;

//登录、注册成功后下一步
-(void)LoginNext;
-(void)RegistNext;
-(void)CancelProcess;
@end
