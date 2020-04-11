//
//  DMBaseViewController.m
//  GoodChilds
//
//  Created by apple on 16/7/21.
//  Copyright © 2016年 duanmu. All rights reserved.
//

#import "DMBaseViewController.h"
#import "DMDefine.h"
#import "JSONModelError.h"
#import "UIColor+Extend.h"
#import "ProgressPublic.h"
@interface DMBaseViewController ()

@end

@implementation DMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENALLHEIGHT);
    self.view.backgroundColor = [UIColor lightGrayColor];
    if(self.navigationController.viewControllers.count>1){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 22, 42);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button setImage:[UIImage imageNamed:@"nav-Back"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"nav-Back"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(backToVC) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [self.navigationItem setLeftBarButtonItem:leftItem];
    }
    // Do any additional setup after loading the view.
}
-(void)backToVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self.navigationController.viewControllers.count>1)
        [self.navigationController setNavigationBarHidden:NO animated:NO];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if(self.navigationController.viewControllers.count>1)
        [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (BOOL)hidesBottomBarWhenPushed {
    if(self.navigationController.viewControllers.count>1){
        return YES;
    }else{
        return NO;
    }
}
-(void)pushViewController:(NSString *)viewControllerName withArgment:(NSDictionary *)argDict{
    Class viewControllerClass=NSClassFromString(viewControllerName);
    DMBaseViewController *viewController = [[viewControllerClass alloc] init];
    if([viewController isKindOfClass:[DMBaseViewController class]] && viewController!=nil){
        viewController.argDict = argDict;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}


-(void)showError:(NSError *)error
{
    [ProgressPublic showError:error withDuration:1.8];
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
