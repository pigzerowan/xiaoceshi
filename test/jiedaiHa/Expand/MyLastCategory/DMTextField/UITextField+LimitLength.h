//
//  UITextField+LimitLength.h
//  SmallTaurus
//
//  Created by Fuer on 14-7-8.
//  Copyright (c) 2014年 FuEr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (LimitLength)
/**
 *  使用时只要调用此方法，加上一个长度(int)，就可以实现了字数限制,汉字不可以
 *
 *  @param length
 */
- (void)limitTextLength:(int)length;
/**
 *  uitextField 抖动效果
 */
- (void)shake;
@end
