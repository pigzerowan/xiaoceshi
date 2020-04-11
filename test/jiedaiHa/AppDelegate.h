//
//  AppDelegate.h
//  jiedaiHa
//
//  Created by 郑渊文 on 2017/6/20.
//  Copyright © 2017年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootTabbarViewController.h"
#import "GFTabBarController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) RootTabbarViewController *m_tabBarController;

/*
 获得当前应用代理
 */
+(AppDelegate*) appDelegate;
@end

