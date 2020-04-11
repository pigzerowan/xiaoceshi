//
//  TaurusContainerViewController.h
//  SmallTaurus
//
//  Created by Sany on 15/3/23.
//  Copyright (c) 2015年 FuEr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaurusContainerViewController : UIViewController
@property (strong, nonatomic) UIViewController *selectedViewController;

-(void)setSelectedViewControllerName:(NSString *)viewControllerName ;

@end
