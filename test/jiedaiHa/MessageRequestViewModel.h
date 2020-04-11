//
//  MessageRequestViewModel.h
//  jiedaiHa
//
//  Created by 郑渊文 on 2020/4/11.
//  Copyright © 2020 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageRequestViewModel : NSObject
@property (nonatomic, strong) NSArray *catches;
@property (nonatomic, strong) NSArray *morecatches;
@property (nonatomic, copy) NSString *lastTime;

@property (nonatomic) unsigned long long pageNumber;
/**
 *  是否有更多数据
 */
@property (nonatomic, strong) RACSubject *moreObject;

@property (nonatomic, strong) RACCommand *pullToRefreshCommand;
@property (nonatomic, strong) RACCommand *infiniteScrollCommand;
@end

NS_ASSUME_NONNULL_END
