//
//  GuideController.h
//  GoldGiant
//
//  Created by Fuer on 15/2/13.
//  Copyright (c) 2015年 Sany. All rights reserved.
//
//引导页面
#import <UIKit/UIKit.h>
@protocol GuideViewControllerDelegate <NSObject>
@end

typedef void(^GuideViewControllerCompletionBlock)();

@interface GuideController : UICollectionViewController
/**
 *  初始化引导页控制器
 *
 *  @param imageNames 图片名数组
 */
- (instancetype)initWithImgNames:(NSArray *)imageNames;
//确定生成的block
-(void)finishGuideViewCompletion:GuideViewControllerCompletionBlock;

@property(copy,nonatomic) GuideViewControllerCompletionBlock guideViewCompletionBlock;//完成的block
@end
