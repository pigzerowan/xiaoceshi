//
//  GFTabBarController.m
//  GFBS
//
//  Created by apple on 16/11/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFTabBarController.h"
//#import "GFNavigationController.h"
//
//#import "GFMeViewController.h"
//#import "GFEssenceViewController.h"
//#import "GFPublishView.h"
//#import "GFNewViewController.h"
//#import "GFFriendTrendViewController.h"

#import "EnterForVC.h"
#import "MeVC.h"
#import "UserSetting.h"
#import "LoginManager.h"
#import "AppDelegate.h"
//#import "UIColor+Extend.h"
#import "DMGCURLManager.h"



#import "GFTabBar.h"


@interface GFTabBarController ()<UITabBarControllerDelegate>

@end

@implementation GFTabBarController

//只加载一次
#pragma mark - 设置tabBar字体格式
//+(void)load
//{
//    UITabBarItem *titleItem = [UITabBarItem appearanceWhenContainedIn:self, nil];
//    //正常
//    NSMutableDictionary *normalDict = [NSMutableDictionary dictionary];
//    normalDict[NSFontAttributeName] = [UIFont systemFontOfSize:13];
//    normalDict[NSForegroundColorAttributeName] = [UIColor grayColor];
//    [titleItem setTitleTextAttributes:normalDict forState:UIControlStateNormal];
//    //选中
//    NSMutableDictionary *selectedDict = [NSMutableDictionary dictionary];
//    selectedDict[NSForegroundColorAttributeName] = [UIColor blackColor];
//    [titleItem setTitleTextAttributes:selectedDict forState:UIControlStateSelected];
//}

- (void)viewWillLayoutSubviews{
    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
    tabFrame.size.height = 55;
    tabFrame.origin.y = self.view.frame.size.height - 55;
    self.tabBar.frame = tabFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  

    [self initRootTabbarView];
    //更换系统tabbar
    [self setUpTabBar];
}

#pragma mark - 更换系统tabbar
-(void)setUpTabBar
{
    GFTabBar *tabBar = [[GFTabBar alloc] init];
    tabBar.backgroundColor = [UIColor whiteColor];
    //把系统换成自定义
    [self setValue:tabBar forKey:@"tabBar"];
}

#pragma mark - 添加所有按钮内容
-(void)setUpTabBarBtn
{
    UINavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"星活动";
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0xD9 / 255.0 green:0x1D / 255.0 blue:0x37 / 255.0 alpha:1]} forState:UIControlStateSelected];
    nav.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"星动态";
    [nav1.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0xD9 / 255.0 green:0x1D / 255.0 blue:0x37 / 255.0 alpha:1]} forState:UIControlStateSelected];

    nav1.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    nav1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
    
    
    UINavigationController *nav2 = self.childViewControllers[2];
    nav2.tabBarItem.title = @"星商城";
    [nav2.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0xD9 / 255.0 green:0x1D / 255.0 blue:0x37 / 255.0 alpha:1]} forState:UIControlStateSelected];

    nav2.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    nav2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    
    
    UINavigationController *nav3 = self.childViewControllers[3];
    nav3.tabBarItem.title = @"星宝贝";
    [nav3.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0xD9 / 255.0 green:0x1D / 255.0 blue:0x37 / 255.0 alpha:1]} forState:UIControlStateSelected];

    nav3.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    nav3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    
}



- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    //这里判断有没有登录
    if (2 == (unsigned long)[tabBarController.viewControllers indexOfObject:viewController]||3 == (unsigned long)[tabBarController.viewControllers indexOfObject:viewController]) {
        if(![[UserSetting provider] checkLogin])
        {
            [[LoginManager provider] showLogin:[AppDelegate appDelegate].window.rootViewController completion:^(LoginObjectResult11 LoginResult){
                if(LoginResult == LoginObjectResultSuccess3){
                    tabBarController.selectedIndex = [tabBarController.viewControllers indexOfObject:viewController];
                }
            }];
            return NO;
        }else{
            tabBarController.selectedIndex = [tabBarController.viewControllers indexOfObject:viewController];
        }
    }
    return YES;
}


-(void)initRootTabbarView
{
    EnterForVC *oneVc = [[EnterForVC alloc]init];

       oneVc.navigationItem.title = @"星活动";
    MeVC *twoVc = [[MeVC alloc]init];
    
    twoVc.navigationItem.title = @"";

    
    MeVC *fourVC = [[MeVC alloc]init];
    fourVC.navigationItem.title = @"星宝贝";
    
    NSArray *vcArray = [NSArray arrayWithObjects:oneVc,twoVc ,fourVC,nil];
    NSArray *titleArr = @[@"星活动",@"星动态",@"星商城"];
    NSMutableArray *navcontrollersArray = [[NSMutableArray alloc]init];
    for(int i =0;i<vcArray.count;i++){
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[vcArray objectAtIndex:i]];
        
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"bt_green.png"]  forBarMetrics:UIBarMetricsDefault];
        
        [nav.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:20],NSFontAttributeName,[UIColor lightGrayColor],NSForegroundColorAttributeName, nil]];
        nav.tabBarItem = [[UITabBarItem alloc]initWithTitle:[titleArr objectAtIndex:i] image:[[UIImage imageNamed:[NSString stringWithFormat:@"tabbar_unselected%d",i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:[NSString stringWithFormat:@"tabbar_selected%d",i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        nav.navigationBar.barStyle = UIBarStyleDefault;
        
        [navcontrollersArray addObject:nav];
    }
    self.delegate = self;
    self.viewControllers = navcontrollersArray;
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName,nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName,[UIColor lightGrayColor],NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    
    //NSLog(@"-----%f",self.tabBar.frame.size.height);
}


@end
