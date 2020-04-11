//
//  RegistModel.h
//  GoodChilds
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 duanmu. All rights reserved.
//

#import "JSONModel.h"

@interface RegistDataModel : JSONModel
@property(nonatomic,strong)NSString<Optional> *token;//用户token
@property(nonatomic,strong)NSString<Optional> *phone;//用户token

@end


@interface RegistPagerModel : JSONModel

@end

@interface RegistModel : JSONModel
@property(nonatomic,strong)NSString<Optional>*code;
@property(nonatomic,strong)NSString<Optional>*msg;//
@property(nonatomic,strong)RegistDataModel<Optional> *data;
@property(nonatomic,strong)RegistPagerModel<Optional> *pager;

@end
