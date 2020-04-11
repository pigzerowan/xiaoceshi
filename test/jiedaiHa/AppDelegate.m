//
//  AppDelegate.m
//  jiedaiHa
//
//  Created by 郑渊文 on 2017/6/20.
//  Copyright © 2017年 transfar. All rights reserved.
//

#import "AppDelegate.h"
#import "GuideController.h"
#import "DMNetworking.h"
#import "UserSetting.h"
#import "HeaderManager.h"
#import "UpdateAlertView.h"
#import "ProgressPublic.h"

@interface AppDelegate ()
{
    GuideController *guideVc;
}

@end

@implementation AppDelegate

+(AppDelegate*) appDelegate
{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    /**
     *  设置DMNetworking
     */
    
    //开启监听
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                // NSLog(@"无网络");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                //NSLog(@"WiFi网络");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                //    NSLog(@"无线网络");
                break;
            }
            default:
                break;
        }
        
    }];
    
    [DMNetworking setTimeout:50];
    
    [HeaderManager updateHeader];

    
    //引导页
    NSString * app_Version = [[NSUserDefaults standardUserDefaults] valueForKey:@"Version"];
    //更新新版本后也要显示新的引导页
    if (app_Version==nil ||([app_Version isEqualToString:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]]==NO)){//首次进入程序显示介绍页
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{ //
                
    
                guideVc = [[GuideController alloc] initWithImgNames:[NSArray arrayWithObjects:@"loading1", @"loading2",@"loading3",@"loading4", nil]];
                
                
                [self.m_tabBarController addChildViewController:guideVc];
                [self.m_tabBarController.view addSubview:guideVc.view];//可以把引导页面放在tabbar.view的最上面来处理。这样每次更新就不会先出现解锁页面了（已设置过）
                //放到最顶层;
                [self.window bringSubviewToFront:guideVc.view];
                [guideVc finishGuideViewCompletion:^(){
                    //首页动画
                    
                }];
                [[NSUserDefaults standardUserDefaults] setValue:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] forKey:@"Version"];
            });
        });
    }



    return YES;
}



- (void)judgeShowIntroView
{
    NSUserDefaults *userInfoxx = [NSUserDefaults standardUserDefaults];
    if ([userInfoxx floatForKey:iYQUserVersionKey] < iYQUserVersion) {
//        _rootView = self.navigationController.view;
        [self showIntroWithCustomView];
    }
    [userInfoxx setFloat:iYQUserVersion forKey:iYQUserVersionKey];
    [userInfoxx synchronize];
}
- (void)showIntroWithCustomView {
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
