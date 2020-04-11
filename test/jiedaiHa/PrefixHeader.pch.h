//
//  PrefixHeader.pch.h
//  LKBforBussiness
//
//  Created by 郑渊文 on 3/27/17.
//  Copyright © 2017 transfar. All rights reserved.
//

#ifndef PrefixHeader_pch_h
#define PrefixHeader_pch_h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIView+FLKAutoLayout.h"
#import "MBProgressHUD.h"
#import "DMDefine.h"
#import "AFNetworkReachabilityManager.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

#import "LKBMacroDefine.h"

#import <MobileCoreServices/MobileCoreServices.h>

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
#import <Masonry.h>


//日期分类
//#import "NSDate+GFExtension.h"


//图片处理
//#import "UIImage+GFImage.h"
//#import "NSJSONSerialization+Manage.h"
// Include any system framework and library headers here that should be included in all compilation units.
// You will also need to set the Prefix Header build setting of one or more of your targets to reference this file.



#define ALERT_MSG(msg) static UIAlertView *alert; alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];\
[alert show];\

#endif /* PrefixHeader_pch */
