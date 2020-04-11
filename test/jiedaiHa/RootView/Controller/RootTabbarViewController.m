//
//  RootTabbarViewController.m
//  GoodChild
//
//  Created by apple on 16/7/21.
//  Copyright © 2016年 duanmu. All rights reserved.
//

#import "RootTabbarViewController.h"
#import "EnterForVC.h"
#import "MeVC.h"
#import "UserSetting.h"
#import "LoginManager.h"
#import "AppDelegate.h"
//#import "UIColor+Extend.h"

@interface RootTabbarViewController ()<UITabBarControllerDelegate>

@end

@implementation RootTabbarViewController
- (void)viewWillLayoutSubviews{
    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
    tabFrame.size.height = 55;
    tabFrame.origin.y = self.view.frame.size.height - 55;
    self.tabBar.frame = tabFrame;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initRootTabbarView];
    // Do any additional setup after loading the view.
}

-(void)initRootTabbarView
{
    EnterForVC *oneVc = [[EnterForVC alloc]init];

    MeVC *twoVc = [[MeVC alloc]init];
    twoVc.navigationItem.title = @"星宝贝";
    
    MeVC *fourVC = [[MeVC alloc]init];
    fourVC.navigationItem.title = @"星宝贝";
    
    NSArray *vcArray = [NSArray arrayWithObjects:oneVc,twoVc ,fourVC,nil];
    NSArray *titleArr = @[@"好童星",@"星活动",@"星动态",@"星宝贝"];
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
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    //这里判断有没有登录
    if (2 == (unsigned long)[tabBarController.viewControllers indexOfObject:viewController]) {
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
