//
//  LoginViewController.m
//  GoodChilds
//
//  Created by apple on 16/7/21.
//  Copyright © 2016年 duanmu. All rights reserved.
//

#import "LoginViewController.h"
//#import "UITextField+LeftImage.h"
//#import "UITextField+LimitLength.h"
#import "QYRegularExpression.h"
#import "AsteriskTool.h"
#import "LoginFirstRequestViewModel.h"
//#import "ProgressPublic.h"
@interface LoginViewController ()
{
    __weak IBOutlet UITextField *m_phoneNum2;
    __weak IBOutlet UIButton *m_nextBt;
    BOOL IsShow;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *m_nextBtLayoutTop;
@property (weak, nonatomic) IBOutlet UITextField *m_phoneText;
@property(nonatomic,strong)LoginFirstRequestViewModel *viewModel;
@end

@implementation LoginViewController
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.m_phoneText becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"填写手机号码";
    [m_nextBt.layer setMasksToBounds:YES];
    [m_nextBt.layer setCornerRadius:5.0];
//    [self.m_phoneText setLeftImageWithImage:@"phone_icon"];
//    [self.m_phoneText limitTextLength:11];
    IsShow = NO;
    
    
    RAC(self.viewModel, phoneNum) = RACObserve(self, m_phoneText.text);
    
    RACSignal *validUsernameSignal =
    [self.m_phoneText.rac_textSignal
     map:^id(NSString *text) {
         return @([self isValidPhone:text]);
     }];
    
    RACSignal *signUpActiveSignal =
    [RACSignal combineLatest:@[validUsernameSignal]
                      reduce:^id(NSNumber *usernameValid) {
                          return @([usernameValid boolValue]);
                      }];
    
    [signUpActiveSignal subscribeNext:^(NSNumber *signupActive) {
        m_nextBt.enabled = [signupActive boolValue];
        if (m_nextBt.enabled) {
            m_nextBt.alpha = 1.0;
        }else{
            m_nextBt.alpha = 0.6;
        }
    }];
    //
    
    [[[m_nextBt
       rac_signalForControlEvents:UIControlEventTouchUpInside]
      doNext:^(id x) {
          m_nextBt.enabled = NO;
      }]
     subscribeNext:^(NSNumber *signedIn) {
         m_nextBt.enabled = YES;
         //登录事件
         [self detectionPhoneRequest];
     }];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)updateViewConstraints
{
    [super updateViewConstraints];
    if ( IsShow == NO) {
        self.m_nextBtLayoutTop.constant = -32;

    }else{
        self.m_nextBtLayoutTop.constant = 44;
        
    }
}

-(BOOL)isValidPhone:(NSString *)phoneNo
{
    if (![QYRegularExpression isPhoneNumber:phoneNo] && phoneNo.length==11) {

//        [ProgressPublic showSimple:@"请输入正确的手机号码" withDuration:1.3];
    }
    m_phoneNum2.text = [AsteriskTool phoneNumAddblank:self.m_phoneText.text];
    if (self.m_phoneText.text.length>0) {
        [self showPhoneNum];
    }else{
        [self hiddenPhoneNum];
    }
    return ([QYRegularExpression isPhoneNumber:phoneNo]);
}
-(void)showPhoneNum
{
    IsShow = YES;
    m_phoneNum2.alpha = 1.0;
    [self.view setNeedsUpdateConstraints];
    
}

-(void)hiddenPhoneNum
{
    IsShow = NO;
    m_phoneNum2.alpha = 0.0;;
    //
    [self.view setNeedsUpdateConstraints];
}

-(LoginFirstRequestViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [LoginFirstRequestViewModel new];
    }
    return _viewModel;
}
-(void)detectionPhoneRequest
{
    [self.viewModel.requestSignal subscribeNext:^(id x) {
        //@strongify(self);
        // 请求完成后
        if ([x isEqualToString:@"DMNoRegistered"]) {
            // 注册
            [self pushViewController:@"RegistVC" withArgment:@{@"phoneNum":self.m_phoneText.text,@"type":[NSNumber numberWithInteger:LoginObjResultReg22]}];
        }else if ([x isEqualToString:@"DMRegistered"]){
            //已注册返回到登录页面
            [self pushViewController:@"LoginInViewController" withArgment:@{@"phoneNum":self.m_phoneText.text}];
        }
    } error:^(NSError *error) {
        //请求失败
        [self showError:error];
        
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
