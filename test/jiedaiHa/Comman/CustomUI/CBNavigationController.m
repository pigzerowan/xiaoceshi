//
//  CBNavigationController.m
//  SmallTaurus
//
//  Created by Sany on 15/3/23.
//  Copyright (c) 2015年 FuEr. All rights reserved.
//

#import "CBNavigationController.h"
#import "MeVC.h"
@interface CBNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end


@implementation CBNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    __weak CBNavigationController *weakSelf = self;
    self.delegate = weakSelf;
}

// Hijack the push method to disable the gesture

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = NO;
    [super pushViewController:viewController animated:animated];
}
//- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
//    if (animated) {
//        self.interactivePopGestureRecognizer.enabled = NO;
//    }
//    return  [super popToRootViewControllerAnimated:animated];
//}
//
//- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    self.interactivePopGestureRecognizer.enabled = NO;
//    return [super popToViewController:viewController animated:animated];
//}
#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    // Enable the gesture again once the new controller is shown
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        if(self.viewControllers.count>1 && ![viewController isKindOfClass:[MeVC class]]){
            self.interactivePopGestureRecognizer.enabled = YES;
        }else{
            self.interactivePopGestureRecognizer.enabled = NO;
        }
    }
  
    __weak CBNavigationController *weakSelf = self;

    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        if(self.viewControllers.count>1){
            self.interactivePopGestureRecognizer.delegate = weakSelf;
        }else{
            self.interactivePopGestureRecognizer.delegate = nil;
        }
    }
    
}

#pragma mark UIGestureRecognizerDelegate

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}

@end
