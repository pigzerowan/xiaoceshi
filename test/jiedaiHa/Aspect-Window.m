//
//  Aspect-Window.m
//  PPJiJin
//
//  Created by Sany on 15/7/3.
//  Copyright (c) 2015年 Sany. All rights reserved.
//
/**
 *  window加载tabbar
 *
 *  @param AppDelegate
 *
 *  @return
 */
#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <XAspect/XAspect.h>
#import "GFTabBarController.h"
#import "UserSetting.h"
//#import "XHLaunchAd.h"
#import "DMNetworking.h"
#import "DMGCURLManager.h"
#define AtAspect Window

#define AtAspectOfClass AppDelegate
@classPatchField(AppDelegate)

AspectPatch(-, void,application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions)
{
//    [UserSetting provider].DoMain = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"Domain"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.m_tabBarController = [[RootTabbarViewController alloc] init];
    self.window.rootViewController = self.m_tabBarController;
    
//    XHLaunchAd *launchAd = [[XHLaunchAd alloc] initWithFrame:[[UIScreen mainScreen] bounds] andDuration:2.0];
    

//    [DMNetworking getWithUrl:[DMGCURLManager appInfor] params:nil  success:^(id response) {
//        AppInforModel *appinfoModel = [[AppInforModel alloc]initWithDictionary:response error:nil];
//       
//        [launchAd imgUrlString:appinfoModel.data.startImg completed:^(UIImage *image, NSURL *url) {
//        }];
//        
//    } fail:^(NSError *error) {
//        
//    } showHUD:NO];
    
//    [self.window.rootViewController.view addSubview:launchAd];
    
    [self.window makeKeyAndVisible];
    XAMessageForward(application:application didFinishLaunchingWithOptions:launchOptions);
}
@end
#undef AtAspectOfClass

#undef AtAspect
