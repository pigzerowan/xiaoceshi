//
//  MessageModel.h
//  jiedaiHa
//
//  Created by 郑渊文 on 2020/4/11.
//  Copyright © 2020 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"


@protocol ActivityListResultModel
@end
@interface ActivityListResultModel : JSONModel
@property(nonatomic,strong)NSString<Optional>*creationTime;
@property(nonatomic,strong)NSString<Optional>*content;
@property(nonatomic,strong)NSString<Optional>*type;
@property(nonatomic,strong)NSString<Optional>*state;
@property(nonatomic,strong)NSString<Optional>*id;//

@end

@interface ActivityPagerModel : JSONModel
@property(nonatomic,strong)NSString<Optional>*currentPage;
@property(nonatomic,strong)NSString<Optional>*pageSize;//
@property(nonatomic,strong)NSString<Optional>*totalPage;
@property(nonatomic,strong)NSString<Optional>*totalResult;//
@end



@interface MessageModel : JSONModel
//@property(nonatomic,strong)NSString<Optional>*code;
//@property(nonatomic,strong)ActivityPagerModel *pager;
@property(nonatomic,strong)NSArray<ActivityListResultModel> *items;
@end


