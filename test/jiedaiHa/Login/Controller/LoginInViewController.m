//
//  LoginInViewController.m
//  GoodChilds
//
//  Created by apple on 16/7/21.
//  Copyright © 2016年 duanmu. All rights reserved.
//

#import "LoginInViewController.h"
#import "UserSetting.h"
#import "UIImageView+YYWebImage.h"
#import "UITextField+LimitLength.h"
#import "UITextField+LeftImage.h"
#import "DMNetworking.h"
#import "DMGCURLManager.h"
#import "RandomTools.h"
#import "RegistModel.h"
#import "LoginManager.h"
#import "QYRegularExpression.h"
#import "ProgressPublic.h"
#import "HeaderManager.h"
@interface LoginInViewController ()
{
    __weak IBOutlet UIImageView *m_headImgView;
    __weak IBOutlet UITextField *m_psdText;
    __weak IBOutlet UILabel *m_phoneLab;
    __weak IBOutlet UIButton *m_loginBt;
    
}
@property(nonatomic,strong)RegistModel *registModel;
- (IBAction)forgotEvent:(id)sender;
- (IBAction)loginEvent:(id)sender;
@end

@implementation LoginInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    m_headImgView.layer.cornerRadius = CGRectGetHeight(m_headImgView.bounds)/2;
    m_headImgView.clipsToBounds = YES;
    [m_headImgView yy_setImageWithURL:[NSURL URLWithString:[UserSetting provider].PhotoUrl] placeholder:[UIImage imageNamed:@"default_headImg"]];
    m_phoneLab.text = [UserSetting provider].PhoneNumOmit;
    
    [m_loginBt.layer setMasksToBounds:YES];
    [m_loginBt.layer setCornerRadius:5.0];
    [m_psdText setLeftImageWithImage:@"psd_icon"];
    [m_psdText limitTextLength:16];
    
    
    RACSignal *validPsdSignal =
    [m_psdText.rac_textSignal
     map:^id(NSString *text) {
         return @([self isValidPassword:text]);
     }];
    
    
    
    RACSignal *signUpActiveSignal =
    [RACSignal combineLatest:@[validPsdSignal]
                      reduce:^id(NSNumber *psdValid) {
                          return @([psdValid boolValue]);
                      }];
    
    [signUpActiveSignal subscribeNext:^(NSNumber *signupActive) {
        m_loginBt.enabled = [signupActive boolValue];
    }];
}
- (BOOL)isValidPassword:(NSString *)password {
    if (![QYRegularExpression isValidatePassword:password]&& password.length>6) {
        m_psdText.text = @"";
        [ProgressPublic showSimple:@"请输入6-16位数字、字母组合密码" withDuration:1.5];
    }
    return [QYRegularExpression isValidatePassword:password];
}


- (IBAction)forgotEvent:(id)sender {
    [self pushViewController:@"RegistVC" withArgment:@{@"phoneNum":[self.argDict objectForKey:@"phoneNum"],@"type":[NSNumber numberWithInteger:LoginObjResultForgot33]}];
}

- (IBAction)loginEvent:(id)sender {
    [UserSetting provider].Code = [RandomTools get10RandomNumbers];
    [HeaderManager updateHeader];
    @weakify(self);
    [DMNetworking getWithUrl:[DMGCURLManager login] params:@{@"phone":[self.argDict objectForKey:@"phoneNum"],@"pwd":m_psdText.text} success:^(id response) {
        @strongify(self);
        self.registModel = [[RegistModel alloc]initWithDictionary:response error:nil];
       
        if (self.registModel.code.integerValue == 1) {
            //保存token,随机10位code
            [UserSetting provider].Token = self.registModel.data.token?self.registModel.data.token:@"";
            [UserSetting provider].Code = [UserSetting provider].Code;
            [UserSetting provider].PhoneNum = self.registModel.data.phone?self.registModel.data.phone:@"";
            
            [[UserSetting provider] saveAccount];
            NSMutableDictionary *tokenHeader = [[NSMutableDictionary alloc] init];
            
            if([UserSetting provider].Token)
                [tokenHeader setValue:[UserSetting provider].Token forKey:@"token"];
            if([UserSetting provider].Code)
                [tokenHeader setValue:[UserSetting provider].Code forKey:@"code"];
            [DMNetworking commonHttpHeaders:tokenHeader];
            
            [[LoginManager provider] LoginNext];
        }else {
            [ProgressPublic showSimple:self.registModel.msg withDuration:1.5];
        }
        
    } fail:^(NSError *error) {
         [self showError:error];
    } showHUD:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
