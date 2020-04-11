//
//  CommonModel.h
//  GoodChilds
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 duanmu. All rights reserved.
//

#import "JSONModel.h"

@interface CommonPagerModel : JSONModel

@end

@interface CommonDataModel : JSONModel
@property(nonatomic,strong)NSString<Optional>*photoUrl;
@property(nonatomic,strong)NSString<Optional>*userName;//
@end

@interface CommonModel : JSONModel
@property(nonatomic,strong)NSString<Optional>*code;
@property(nonatomic,strong)NSString<Optional>*msg;//
@property(nonatomic,strong)CommonDataModel<Optional>*data;//

@property(nonatomic,strong)CommonPagerModel *pager;
@end
