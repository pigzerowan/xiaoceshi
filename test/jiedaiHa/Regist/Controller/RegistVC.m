//
//  RegistVC.m
//  GoodChilds
//
//  Created by apple on 16/7/21.
//  Copyright © 2016年 duanmu. All rights reserved.
//

#import "RegistVC.h"
#import "CustomSecureTextField.h"
#import "UITextField+LimitLength.h"
#import "UITextField+LeftImage.h"
#import "NSMutableAttributedString+Attributes.h"
#import "QYRegularExpression.h"
#import "JKCountDownButton.h"
#import "DMNetworking.h"
#import "DMGCURLManager.h"
#import "CommonModel.h"
#import "RegistModel.h"
#import "LoginManager.h"
#import "UIColor+Extend.h"
#import "RandomTools.h"
#import "UserSetting.h"
#import "ProgressPublic.h"
#import "HeaderManager.h"
#import "AsteriskTool.h"
@interface RegistVC ()
{
    __weak IBOutlet UILabel *m_titleLab;
    __weak IBOutlet UITextField *m_codeText;
    __weak IBOutlet CustomSecureTextField *m_psdText;
    __weak IBOutlet UILabel *m_xieyiLab;
    
    __weak IBOutlet JKCountDownButton *m_codeBt;
    __weak IBOutlet UIButton *m_registBt;
    __weak IBOutlet NSLayoutConstraint *m_imgLineLayH;
    NSString *m_type;
    
    __weak IBOutlet UIButton *m_selectBt;
    
}
@property(nonatomic,strong)CommonModel *commonModel;
@property(nonatomic,strong)RegistModel *registModel;
- (IBAction)openEye:(id)sender;
- (IBAction)clickRegist:(id)sender;
- (IBAction)getCodeRequest:(id)sender;

@end

@implementation RegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.argDict) {
        m_titleLab.text = [NSString stringWithFormat:@"验证码已发送至%@",[AsteriskTool phoneNumToAsterisk:[self.argDict objectForKey:@"phoneNum"]]];
        m_type = [self.argDict objectForKey:@"type"];
        if (m_type.integerValue == 1) {
            self.navigationItem.title = @"注册";
            [m_registBt setTitle:@"注册" forState:UIControlStateNormal];
            [m_registBt setTitle:@"注册" forState:UIControlStateHighlighted];
            m_selectBt.hidden = NO;
            m_xieyiLab.hidden = NO;
        }else{
            self.navigationItem.title = @"找回密码";
            [m_registBt setTitle:@"确定" forState:UIControlStateNormal];
            [m_registBt setTitle:@"确定" forState:UIControlStateHighlighted];
            m_selectBt.hidden = YES;
            m_xieyiLab.hidden = YES;
            
        }
    }
    [m_codeText setLeftImageWithImage:@"phone_icon"];
    [m_psdText setLeftImageWithImage:@"psd_icon"];
    [m_codeText limitTextLength:6];
    [m_psdText limitTextLength:16];
    
    [m_registBt.layer setMasksToBounds:YES];
    [m_registBt.layer setCornerRadius:5.0];
    
    m_codeBt.layer.borderColor = [UIColor lightGrayColor].CGColor;
    m_codeBt.layer.borderWidth = 0.5;

    [m_codeBt.layer setMasksToBounds:YES];
    [m_codeBt.layer setCornerRadius:5.0];
    
    m_imgLineLayH.constant = 0.5;
    NSString *str = @"我同意《好童星注册协议》";
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
//    [attStr addColor:[UIColor blackColor] substring:@"我同意"];
    m_xieyiLab.attributedText = attStr;
    //增加协议点击手势
    m_xieyiLab.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(agreement:)];
    [m_xieyiLab addGestureRecognizer:tapGesture2];

    RACSignal *validCodeSignal =
    [m_codeText.rac_textSignal
     map:^id(NSString *text) {
         return @([self isValidCode:text]);
     }];
    
    RACSignal *validPsdSignal =
    [m_psdText.rac_textSignal
     map:^id(NSString *text) {
         return @([self isValidPassword:text]);
     }];
    
    
    
    RACSignal *signUpActiveSignal =
    [RACSignal combineLatest:@[validPsdSignal, validCodeSignal]
                      reduce:^id(NSNumber *psdValid, NSNumber *codeValid) {
                          return @([psdValid boolValue] && [codeValid boolValue]);
                      }];
    
    [signUpActiveSignal subscribeNext:^(NSNumber *signupActive) {
        m_registBt.enabled = [signupActive boolValue];
        if (m_registBt.enabled) {
            m_registBt.alpha = 1.0;
        }else{
            m_registBt.alpha = 0.6;
        }
    }];
    
    [self getCodeRequest:m_codeBt];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)agreement:(id)sender
{
    [self pushViewController:@"WebViewManger" withArgment:@{@"URL":[DMGCURLManager userRule]}];
}
- (BOOL)isValidCode:(NSString *)code
{
    return code.length == 6;
}

- (BOOL)isValidPassword:(NSString *)password {
    if (![QYRegularExpression isValidatePassword:password]&& password.length>6) {
        m_psdText.text = @"";
        [ProgressPublic showSimple:@"请输入6-16位数字、字母组合密码" withDuration:1.5];
    }
    return [QYRegularExpression isValidatePassword:password];
}



- (IBAction)openEye:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    m_psdText.secureTextEntry = !button.selected;
}

- (IBAction)clickRegist:(id)sender {
    if([QYRegularExpression isValidatePassword:m_psdText.text]&& (m_codeText.text.length==6)){
        m_registBt.enabled = NO;
        [UserSetting provider].Code = [RandomTools get10RandomNumbers];
        [HeaderManager updateHeader];
        @weakify(self);
        NSString *m_url = nil;
        if (m_type.integerValue == 1) {
            m_url = [DMGCURLManager regist];
        }else{
           m_url = [DMGCURLManager returnPwd];
            
        }
        [self.view endEditing:YES];
        [DMNetworking getWithUrl:m_url params:@{@"phone":[self.argDict objectForKey:@"phoneNum"],@"pwd":m_psdText.text,@"msgCode":m_codeText.text} success:^(id response) {
            @strongify(self);
       
           
            self.registModel = [[RegistModel alloc]initWithDictionary:response error:nil];
             NSLog(@"---:%@",self.registModel.toJSONString);
            if (self.registModel.code.integerValue == 1) {
                //保存token,随机10位code
                [UserSetting provider].Token = self.registModel.data.token?self.registModel.data.token:@"";
                [UserSetting provider].Code = [UserSetting provider].Code;
                [UserSetting provider].PhoneNum = self.registModel.data.phone?self.registModel.data.phone:@"";
        
                [[UserSetting provider] saveAccount];
                [HeaderManager updateHeader];
                [[LoginManager provider] LoginNext];
            }else {
                [ProgressPublic showSimple:[response objectForKey:@"msg"] withDuration:1.5];
            }
            
        } fail:^(NSError *error) {
             [self showError:error];
        } showHUD:NO];
    }
}

- (IBAction)getCodeRequest:(id)sender {
    @weakify(self);
    [DMNetworking getWithUrl:[DMGCURLManager sendSms] params:@{@"phone":[self.argDict objectForKey:@"phoneNum"],@"type":m_type} success:^(id response) {
        @strongify(self);
        
        self.commonModel = [[CommonModel alloc]initWithDictionary:response error:nil];
      // NSLog(@"----:%@",self.commonModel.toJSONString);
        if (self.commonModel.code.integerValue == 1) {
            [sender startWithSecond:60];//倒计时间 60秒,2016.7.1修改为60s
            [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
                countDownButton.enabled = NO;
                [countDownButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                NSString *title = [NSString stringWithFormat:@"%d秒",second];
                return title;
            }];
            [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
                [countDownButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                countDownButton.enabled = YES;
                return @"重发";
            }];
        }
    } fail:^(NSError *error) {
         [self showError:error];
    } showHUD:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
