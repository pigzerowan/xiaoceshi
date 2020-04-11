//
//  MessageTabDatasource.h
//  jiedaiHa
//
//  Created by 郑渊文 on 2020/4/11.
//  Copyright © 2020 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageModel.h"

@interface MessageTabDatasource : NSObject<UITableViewDataSource>
@property(nonatomic,strong)NSArray *m_arr;

@end


