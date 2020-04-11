//
//  UITextField+LeftImage.m
//  CheLIZi
//
//  Created by Sany on 15/7/2.
//  Copyright (c) 2015年 Sany. All rights reserved.
//

#import "UITextField+LeftImage.h"

@implementation UITextField (LeftImage)

-(void)setLeftImageWithImage:(NSString *)imageName{
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
    UIImageView *leftViewImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    leftViewImage.center = leftView.center;
    [leftView addSubview:leftViewImage];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

-(void)setLeftTitle:(NSString *)mstring
{
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 90, self.frame.size.height)];
    UILabel *leftLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 21)];
    leftLab.font = [UIFont systemFontOfSize:15.0];
    leftLab.text = mstring;
    leftLab.center = leftView.center;
    [leftView addSubview:leftLab];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;

}

@end
