//
//  MessageTableViewCell.h
//  jiedaiHa
//
//  Created by 郑渊文 on 2020/4/11.
//  Copyright © 2020 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MessageTableViewCell : UITableViewCell
@property(nonatomic,strong)ActivityListResultModel *cellData;

@end

NS_ASSUME_NONNULL_END
