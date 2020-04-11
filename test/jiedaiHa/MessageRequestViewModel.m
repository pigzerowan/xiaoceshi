//
//  MessageRequestViewModel.m
//  jiedaiHa
//
//  Created by 郑渊文 on 2020/4/11.
//  Copyright © 2020 transfar. All rights reserved.
//

#import "MessageRequestViewModel.h"
#import "DMNetworking.h"
#import "DMGCURLManager.h"
#import "MessageModel.h"
@interface MessageRequestViewModel()
@property(nonatomic,strong)MessageModel *m_activityModel;
@end
@implementation MessageRequestViewModel
-(instancetype)init
{
    self = [super init];
    if (!self) return nil;
    self.catches = [NSArray new];
    self.morecatches = [NSArray new];
    
    
    self.pullToRefreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        self.lastTime = @"";
       
        return [self loadCatchesSignal];
    }];
    
    self.infiniteScrollCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        

        return [self loadNextPageSignal];
    }];
    _moreObject = [RACSubject subject];
    return self;
}

- (RACSignal *)loadCatchesSignal
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //这里做网络请求
        @weakify(self);
        [DMNetworking getWithUrl:@"https://3evjrl4n5d.execute-api.us-west-1.amazonaws.com/dev/message" params:@{@"limit":@"10",@"id":@"10",@"direction":@"1"}  success:^(id response) {
            @strongify(self);
            
            self.m_activityModel = [[MessageModel alloc]initWithDictionary:response error:nil];
            self.catches = (NSArray<ActivityListResultModel> *)self.m_activityModel.items;
            ActivityListResultModel*model = self.catches.lastObject;
            self.lastTime = model.creationTime;
            
            [subscriber sendNext:self.catches];
            [subscriber sendCompleted];
        } fail:^(NSError *error) {
            [subscriber sendError:error];
        } showHUD:YES];
        
        return [RACDisposable disposableWithBlock:^
                {
//                    NSLog(@"clear up");
                }];
    }] doError:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (RACSignal *)loadNextPageSignal
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //这里做网络请求
        @weakify(self);
        [DMNetworking getWithUrl:[DMGCURLManager messageList] params:@{@"lastItem":self.lastTime,@"limit":@"10",@"id":@"10",@"direction":@"0"}  success:^(id response) {
            @strongify(self);
            
            MessageModel *m_activityModel2 = [[MessageModel alloc]initWithDictionary:response error:nil];
            NSArray *newLoadedCatches = (NSArray<ActivityListResultModel> *)[self.catches arrayByAddingObjectsFromArray:m_activityModel2.items];
            self.catches = newLoadedCatches;
            ActivityListResultModel*model = self.catches.lastObject;
             self.lastTime = model.creationTime;
            [_moreObject sendNext:m_activityModel2.items];
            
            [subscriber sendNext:self.catches];
            [subscriber sendCompleted];
        } fail:^(NSError *error) {
            [subscriber sendError:error];
        } showHUD:YES];

        return [RACDisposable disposableWithBlock:^
                {
                    //NSLog(@"clear up");
                }];
    }] doError:^(NSError *error) {
        //NSLog(@"%@",error);
    }];
}
@end
