//
//  UIViewController+Utils.h
//  GoodChilds
//
//  Created by Quan on 16/7/30.
//  Copyright © 2016年 duanmu. All rights reserved.
//
/**
 *  获取当前的VC
 *
 *  @param 参考：http://stackoverflow.com/questions/24825123/get-the-current-view-controller-from-the-app-delegate
 *
 *  @return
 */
#import <UIKit/UIKit.h>

@interface UIViewController (Utils)
+(UIViewController*) currentViewController;
@end
