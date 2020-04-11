//
//  UINavigationBar+Background.h
//  CustomNavicationController
//
//  Created by YiJiang Chen on 16/11/21.
//  Copyright (c) 2016年 duanmu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Background)
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;
- (void)lt_setElementsAlpha:(CGFloat)alpha;
- (void)lt_setTranslationY:(CGFloat)translationY;
- (void)lt_reset;

@end
