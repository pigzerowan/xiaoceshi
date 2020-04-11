//
//  TaurusContainerViewController.m
//  SmallTaurus
//
//  Created by Sany on 15/3/23.
//  Copyright (c) 2015年 FuEr. All rights reserved.
//
#import "DMBaseViewController.h"
#import "TaurusContainerViewController.h"

@interface TaurusContainerViewController ()
@property(nonatomic,strong) NSMutableDictionary *viewControllerDict;
@end

@implementation TaurusContainerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _viewControllerDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark Container

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSArray *viewControllers = [self childViewControllersWithAppearanceCallbackAutoForward];
    for (UIViewController *viewController in viewControllers) {
        [viewController beginAppearanceTransition:YES animated:animated];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSArray *viewControllers = [self childViewControllersWithAppearanceCallbackAutoForward];
    for (UIViewController *viewController in viewControllers) {
        [viewController endAppearanceTransition];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    NSArray *viewControllers = [self childViewControllersWithAppearanceCallbackAutoForward];
    for (UIViewController *viewController in viewControllers) {
        [viewController beginAppearanceTransition:NO animated:animated];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    NSArray *viewControllers = [self childViewControllersWithAppearanceCallbackAutoForward];
    for (UIViewController *viewController in viewControllers) {
        [viewController endAppearanceTransition];
    }
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    NSArray *viewControllers = [self childViewControllersWithRotationCallbackAutoForward];
    for (UIViewController *viewController in viewControllers) {
        [viewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
        
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    NSArray *viewControllers = [self childViewControllersWithRotationCallbackAutoForward];
    for (UIViewController *viewController in viewControllers) {
        [viewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    NSArray *viewControllers = [self childViewControllersWithRotationCallbackAutoForward];
    for (UIViewController *viewController in viewControllers) {
        [viewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    }
}

/*
 NS_AVAILABLE_IOS(6_0)
 向下查看和旋转相关的ChildViewController的shouldAutorotate的值
 只有所有相关的子VC都支持Autorotate，才返回YES
 */
- (BOOL)shouldAutorotate{
    NSArray *viewControllers = [self childViewControllersWithRotationCallbackAutoForward];
    BOOL shouldAutorotate = YES;
    for (UIViewController *viewController in viewControllers) {
        shouldAutorotate = shouldAutorotate &&  [viewController shouldAutorotate];
    }
    
    return shouldAutorotate;
}

/*
 NS_AVAILABLE_IOS(6_0)
 此方法会在设备旋转且shouldAutorotate返回YES的时候才会被触发
 根据对应的所有支持的取向来决定是否需要旋转
 作为容器，支持的取向还决定于自己的相关子ViewControllers
 */
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    NSUInteger supportedInterfaceOrientations = UIInterfaceOrientationMaskAll;
    
    NSArray *viewControllers = [self childViewControllersWithRotationCallbackAutoForward];
    for (UIViewController *viewController in viewControllers) {
        supportedInterfaceOrientations = supportedInterfaceOrientations & [viewController supportedInterfaceOrientations];
    }
    
    return supportedInterfaceOrientations;
}


#pragma mark -
#pragma mark 下面两个方法是在需要的情况下给基类覆盖用的，毕竟不是所有的容器都需要将相关方法传递给所有的childViewControllers
- (NSArray *)childViewControllersWithAppearanceCallbackAutoForward{
    return self.childViewControllers;
}

- (NSArray *)childViewControllersWithRotationCallbackAutoForward{
    return self.childViewControllers;
}


-(void)setSelectedViewController:(UIViewController *)selectedViewController{
    if(_selectedViewController){
        [_selectedViewController willMoveToParentViewController:nil]; //1
        [_selectedViewController.view removeFromSuperview]; //2
        [_selectedViewController removeFromParentViewController]; //3
    }
    
    [self addChildViewController:selectedViewController];  //1
    [self.view addSubview:selectedViewController.view]; //2
    [selectedViewController didMoveToParentViewController:self]; //3
    _selectedViewController = selectedViewController;

}

-(void)setSelectedViewControllerName:(NSString *)viewControllerName
{
    DMBaseViewController *viewController = [self.viewControllerDict objectForKey:viewControllerName];
    if(viewController==nil){
        Class viewControllerClass=NSClassFromString(viewControllerName);
        viewController = [[viewControllerClass alloc] init];
    }
    
    if([viewController isKindOfClass:[UIViewController class]] && viewController!=nil){
        [self.viewControllerDict setObject:viewController forKey:viewControllerName];
        self.selectedViewController = viewController;
        
    }

}

@end
