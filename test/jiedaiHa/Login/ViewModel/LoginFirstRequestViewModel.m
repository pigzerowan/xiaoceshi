//
//  LoginFirstRequestViewModel.m
//  GoodChilds
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 duanmu. All rights reserved.
//

#import "LoginFirstRequestViewModel.h"
#import "DMGCURLManager.h"
#import "DMNetworking.h"
#import "CommonModel.h"
#import "UserSetting.h"
@interface LoginFirstRequestViewModel()
@property (nonatomic, strong) RACSignal *phoneSignal;
@property(nonatomic,strong)CommonModel *commonModel;
@end

@implementation LoginFirstRequestViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}
- (void)initialize {
    _phoneSignal = RACObserve(self, phoneNum);
}

-(RACSignal *)requestSignal
{
    if (!_requestSignal) {
        
        @weakify(self);
        _requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [DMNetworking getWithUrl:[DMGCURLManager queryUser] params:@{@"phone":_phoneNum} success:^(id response) {
                @strongify(self);
            
                self.commonModel = [[CommonModel alloc]initWithDictionary:response error:nil];
                //NSLog(@"---:%@,%@",self.commonModel.toJSONString,_phoneNum);
                if (self.commonModel.code.integerValue == 1) {
                    [UserSetting  provider].PhotoUrl = self.commonModel.data.photoUrl;
                    [UserSetting  provider].PhoneNumOmit = self.commonModel.data.userName;
                    [subscriber sendNext:@"DMRegistered"];
                }else if (self.commonModel.code.integerValue == 1101){
                    [subscriber sendNext:@"DMNoRegistered"];
                }
                [subscriber sendCompleted];
            } fail:^(NSError *error) {
                [subscriber sendError:error];
            } showHUD:NO];
            // 在信号量作废时，取消网络氢气
            return [RACDisposable disposableWithBlock:^{
                
            }];
        }];
    }
    
    return _requestSignal;
}


@end
