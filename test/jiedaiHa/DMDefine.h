//
//  DMDefine.h
//  GoodChilds
//
//  Created by apple on 16/7/21.
//  Copyright © 2016年 duanmu. All rights reserved.
//

#ifndef DMDefine_h
#define DMDefine_h



#endif /* DMDefine_h */

#define SCREENWIDTH   [UIScreen mainScreen].bounds.size.width       //320的宽度
#define SCREENALLHEIGHT [UIScreen mainScreen].bounds.size.height       //不去除20个像素屏幕高度
#define GFScreenHeight [UIScreen mainScreen].bounds.size.height 
#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

//------------------颜色---------------------------
#define COLOR_THEME_TITLE  @"#fb4a5e"  //导航上的红色
#define COLOR_THEME_NAV  @"#F6F6F6"  //导航颜色
#define COLOR_THEME_VIEWBACK  @"#EAECEB"  //view颜色
#define COLOR_PINK [UIColor colorWithRed:251.0/255.0 green:66.0/255.0 blue:149.0/255.0 alpha:1.0] //粉红色
//------------------登录---------------------------
typedef NS_ENUM(NSInteger,LoginObjectResult11){
    LoginObjectResultCancel1 = 0,  //取消登录
    LoginObjectResultFailed2 = 1,  //登录失败
    LoginObjectResultSuccess3 = 2, //登录成功
};

//-----------------用来-注册、找回密码---------------------------
typedef NS_ENUM(NSInteger,LoginObjTypeResult22){
    LoginObjResultReg22 = 1,  //注册
    LoginObjResultForgot33 = 2,  //找回密码
};
/* ——————————————————————————网络提示—————————————————————————————————-—— */
#define NETERRORTITLE   @"亲~请检查网络连接！"
#define SYSTEMNETERRORTITLE   @"系统异常，稍后重试！"
#define AGAINLOGINTITLE @"账号已过期，\n请重新登录"
#define NETERRORTITLE2 @"网络超时，请重试！"
#define NETERRORTITLE3 @"~~请检查网络连接！"

#define UPDATEWEBVIEW @"UPDATEWEBVIEW" //更新webview
#define UPDATEWEBVIEW2 @"UPDATEWEBVIEW2" //更新webview
#define kNetworkNotReachability ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus <= 0)  //无网

//http://www.showdoc.cc/testapi?page_id=19792


/* ——————————————————————————友盟appKey————————————————————————————————————————*/
#define UMENG_APPKEY @"5822d2a8717c192156000fea"

/*****************  全局背景色  ******************/
#define GFBgColor  [UIColor colorWithRed:(206/255.0) green:(206/255.0) blue:(206/255.0) alpha:1.0]

/*****************  tag景色  ******************/
#define GFTagBgColor  [UIColor colorWithRed:74 / 255.0 green:139 / 255.0 blue:209 / 255.0 alpha:1.0]

/*****************  tag字体尺寸  ******************/
#define GFTagFont [UIFont systemFontOfSize:14]

#define GFMargin 10
#define GFTagMargin 5
#define GFTagHeight 25


/*头像高*/
#define GFiconH  55
/*底部View(评论，分享，顶，踩) 高*/
#define GFDcrcH  35
/*最热评论label高*/
#define GFHotCommentLabel  18
/*大图压缩高*/
#define GFLargImageCompressH  250

/*UITabBar高度*/
#define GFTabBarH  49

/*导航栏的最大Y值*/
#define GFNavMaxY  64

/*标题栏高度*/
#define GFTitleViewH  35

