//
//  LoginManager.m
//  PPJiJin
//
//  Created by Sany on 15/3/25.
//  Copyright (c) 2015年 Sany. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginManager.h"
#import "LoginViewController.h"
#import "UserSetting.h"
//#import "UIColor+Extend.h"
#import "DMDefine.h"
//#import "QueryUserManager.h"
enum{
    ELoginManagerCommendLogin,
    ELoginManagerCommendBuy
};

enum{
    ELoginManagerStepStart,//开始0
    ELoginManagerStepLogin,//登录1
};

@interface LoginManager()

@property(strong,nonatomic) UINavigationController *navController;
@property(copy,nonatomic) LoginCompletionBlock loginCompletionBlock;
@property(nonatomic) NSInteger Commend;
@property(strong,nonatomic) NSMutableDictionary *stepDict;
@end

@implementation LoginManager

+(LoginManager *)provider
{
    static LoginManager *loginManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loginManager = [[LoginManager alloc]init];
       
    });
    return loginManager;
}

-(void)showLogin:(UIViewController *)inViewController completion:LoginCompletionBlock
{
    self.loginCompletionBlock = LoginCompletionBlock;
    self.Commend = ELoginManagerCommendLogin;
    
    LoginViewController *logingViewControllr =[[LoginViewController alloc] init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 22, 42);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0 ,0);
    [button setImage:[UIImage imageNamed:@"nav-Back"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"nav-Back"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(closeViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [logingViewControllr.navigationItem setLeftBarButtonItem:leftItem];
    
    logingViewControllr.view.frame=CGRectMake(0, 0, SCREENWIDTH, SCREENALLHEIGHT);
    self.navController = [[UINavigationController alloc]initWithRootViewController:logingViewControllr];
    self.navController.navigationBar.barTintColor = [UIColor redColor];
    [self.navController.navigationBar setTintColor:[UIColor redColor]];
    self.navController.navigationBar.translucent = NO;
 
    self.navController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName:[UIFont systemFontOfSize:20]};
    
    [inViewController presentViewController:self.navController animated:YES completion:nil];
}

-(void)LoginNext
{
    if(self.Commend == ELoginManagerCommendLogin){
        [self.navController dismissViewControllerAnimated:YES completion:nil];
        self.navController = nil;
        if(self.loginCompletionBlock){
            self.loginCompletionBlock(LoginObjectResultSuccess3);
            self.loginCompletionBlock = nil;
//            [[QueryUserManager sharedAccountInfo] requestQueryUserBlock:^(id data) {
//                
//            } fail:^(NSError *error) {
//                
//            }];
        }
    }
}

-(void)RegistNext{
    [self LoginNext];
}

-(void)CancelProcess{
    [self closeViewController];
}

-(void)closeViewController{
    [self.navController dismissViewControllerAnimated:YES completion:nil];
     self.navController = nil;
    
    if(self.loginCompletionBlock){
        self.loginCompletionBlock(LoginObjectResultCancel1);
        self.loginCompletionBlock = nil;
    }
    
}
@end
