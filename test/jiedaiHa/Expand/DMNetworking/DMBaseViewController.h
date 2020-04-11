//
//  DMBaseViewController.h
//  GoodChilds
//
//  Created by apple on 16/7/21.
//  Copyright © 2016年 duanmu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMBaseViewController : UIViewController
@property(nonatomic,strong) NSDictionary *argDict;


-(void)pushViewController:(NSString *)viewControllerName withArgment:(NSDictionary *)argDict;
-(void)showError:(NSError *)error;
@end
