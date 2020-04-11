//
//  AppInforModel.h
//  GoodChilds
//
//  Created by apple on 16/7/28.
//  Copyright © 2016年 duanmu. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface AppInforWechatModel :JSONModel
@property(nonatomic,strong)NSString<Optional>*imgUrl;
@property(nonatomic,strong)NSString<Optional>*title;
@property(nonatomic,strong)NSString<Optional>*url;
@property(nonatomic,strong)NSString<Optional>*info;
@end


@interface AppInforDataModel :JSONModel
@property(nonatomic,strong)NSString<Optional>*startImg;
@property(nonatomic,strong)AppInforWechatModel<Optional> *wechat;

@end

@interface AppInforPagerModel :JSONModel
@end

@interface AppInforModel : JSONModel
@property(nonatomic,strong)NSString<Optional>*code;
@property(nonatomic,strong)NSString<Optional>*msg;//
@property(nonatomic,strong)AppInforPagerModel<Optional> *pager;
@property(nonatomic,strong)AppInforDataModel<Optional> *data;

@end
