//
//  ProgressPublic.m
//  SmallTaurus
//
//  Created by Fuer on 14-8-5.
//  Copyright (c) 2014年 FuEr. All rights reserved.
//

#import "ProgressPublic.h"
#import "JSONModelError.h"
#import "DMDefine.h"
@implementation ProgressPublic

+(ProgressPublic*) instance
{
    static ProgressPublic *progressPublic = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        progressPublic = [[ProgressPublic alloc]init];
    });
    return progressPublic;
}

+(void)showSimple:(NSString *)message withDuration:(NSTimeInterval)duration
{
    [SVProgressHUD setMinimumDismissTimeInterval:duration];
    [SVProgressHUD setInfoImage:nil];//这样就不显示Img
    [SVProgressHUD showInfoWithStatus:message];
    
}
+(void)showError:(NSError *)error withDuration:(NSTimeInterval)duration
{
    NSString *errorDesc = error.localizedDescription;
    if([error.domain isEqualToString:NSURLErrorDomain]){
        errorDesc = NETERRORTITLE;
    }else if([error.domain isEqualToString:JSONModelErrorDomain]){
        switch (error.code) {
            case kJSONModelErrorBadResponse:
                errorDesc = @"数据暂不可用";
                break;
                
            default:
                errorDesc = @"获取数据失败";
                break;
        }
    }else if ([error.domain isEqualToString:@"NSCocoaErrorDomain"]){
        errorDesc = @"网络故障，请稍后在试";
        
    }
    [self showSimple:errorDesc withDuration:duration];
}
+(void)showMessage:(NSString *)message withDuration:(NSTimeInterval)duration maskType:(SVProgressHUDMaskType)maskType
{
    [SVProgressHUD setDefaultMaskType:maskType];
    [self showSimple:message withDuration:duration];
    
}

@end
