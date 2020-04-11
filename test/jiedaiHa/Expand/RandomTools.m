//
//  RandomTools.m
//  GoodChilds
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 duanmu. All rights reserved.
//

#import "RandomTools.h"

@implementation RandomTools
+(NSMutableString *)get10RandomNumbers
{
    NSArray *changeArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];//存放十个数，以备随机取
    NSMutableString * getStr = [[NSMutableString alloc] initWithCapacity:10];
    NSMutableString *changeString = [[NSMutableString alloc] initWithCapacity:10];//申请内存空间，一定要写，要不没有效果，我自己总是吃这个亏
    for (int i = 0; i<10; i++) {
        NSInteger index = arc4random()%([changeArray count]-1);//循环六次，得到一个随机数，作为下标值取数组里面的数放到一个可变字符串里，在存放到自身定义的可变字符串
        getStr = changeArray[index];
        changeString = (NSMutableString *)[changeString stringByAppendingString:getStr];
    }
    return changeString;
}
@end
