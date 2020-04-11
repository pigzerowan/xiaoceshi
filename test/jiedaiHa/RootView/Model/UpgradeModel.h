//
//  UpgradeModel.h
//  GoodChilds
//
//  Created by apple on 2016/11/11.
//  Copyright © 2016年 duanmu. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface UpgradeDataModel : JSONModel
@property(nonatomic,strong)NSString<Optional>*STATUS;//	0-不更新，1-更新
@property(nonatomic,strong)NSString<Optional>*VERSION;//	版本号
@property(nonatomic,strong)NSString<Optional>*VERSION_CODE;
@property(nonatomic,strong)NSString<Optional>*ID;//	编号
@property(nonatomic,strong)NSString<Optional>*CONTENT;//更新文本
@property(nonatomic,strong)NSString<Optional>*CREATE_TIME;//	创建时间
@property(nonatomic,strong)NSString<Optional>*URL;//下载地址
@end

@interface UpgradePagerModel : JSONModel

@end

@interface UpgradeModel : JSONModel
@property(nonatomic,strong)NSString<Optional>*code;
@property(nonatomic,strong)NSString<Optional>*msg;//
@property(nonatomic,strong)UpgradePagerModel<Optional> *pager;
@property(nonatomic,strong)UpgradeDataModel<Optional> *data;
@end
