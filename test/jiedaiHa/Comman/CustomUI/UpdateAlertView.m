//
//  UpdateAlertView.m
//  GoodChilds
//
//  Created by apple on 2016/11/11.
//  Copyright © 2016年 duanmu. All rights reserved.
//

#import "UpdateAlertView.h"
#import "UserSetting.h"
@interface UpdateAlertView()
@property (weak, nonatomic) IBOutlet UILabel *m_msgLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *m_layoutH;
@property (weak, nonatomic) IBOutlet UIButton *m_updateBt;
@property (weak, nonatomic) IBOutlet UILabel *m_versionLab;
@property (weak, nonatomic) IBOutlet UIView *m_textInfoView;
@property (weak, nonatomic) IBOutlet UIView *m_myView;

@property (nonatomic,copy) NSString *message;

@property (nonatomic,copy) void (^dialogViewCompleteHandle)(NSInteger);
@end

@implementation UpdateAlertView



-(id)initWithMessage:(NSString *)message
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    self = [super initWithFrame:rect];
    if (self)
    {
        NSString *className = NSStringFromClass([self class]);
        self.view = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] firstObject];
        self.view.frame = rect;
        [self addSubview:self.view];
        
        self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.message = message;
        [self setup];
    }
    
    return self;
}

-(void)setup
{
    [self.m_updateBt.layer setMasksToBounds:YES];
    [self.m_updateBt.layer setCornerRadius:8.0];
    _m_msgLab.text = self.message;
    _m_msgLab.textAlignment = NSTextAlignmentLeft;
    _m_msgLab.numberOfLines = 0;
    
    _m_versionLab.text = [NSString stringWithFormat:@"V%@",[UserSetting provider].serverVersion];
    //http://www.jianshu.com/p/604e350435a2
    /*只要设置左，上，固定宽度
    */
//    CGSize size = [self.view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    NSLog(@"---222:%f",_m_msgLab.frame.size.height);
}
-(void)layoutSubviews {
    [super layoutSubviews];
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    [self.view updateConstraintsIfNeeded];
    
    //图片+按钮+间距
    _m_layoutH.constant = 158 +29+ _m_msgLab.frame.size.height;
    
    float newfloat = 158 +29+ _m_msgLab.frame.size.height;

    CGRect newrect = CGRectMake(self.m_textInfoView.frame.origin.x, self.m_textInfoView.frame.origin.y, self.m_textInfoView.frame.size.width, newfloat-114);
    self.m_textInfoView.frame = newrect;
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.m_textInfoView.bounds
                                     byRoundingCorners:(UIRectCornerBottomRight | UIRectCornerBottomLeft)
                                           cornerRadii:CGSizeMake(15.0f, 15.0f)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.m_textInfoView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.m_textInfoView.layer.mask = maskLayer;
}


-(void)showWithCompletion:(void (^)(NSInteger selectIndex))completeBlock;
{
    self.dialogViewCompleteHandle = completeBlock;
    [UIView animateWithDuration:2.0  animations:^{
        
    } completion:^(BOOL finished) {
        if (finished) {
            [[[UIApplication sharedApplication] keyWindow] addSubview:self];
        }
    }];

}

- (IBAction)closeClick:(id)sender {
    [self hideView];
}

- (IBAction)commitClick:(id)sender {
    UIButton *m_newBt = (UIButton *)sender;
    NSInteger selIndex = m_newBt.tag;
    if(_dialogViewCompleteHandle){
        _dialogViewCompleteHandle(selIndex);
    }
    [self hideView];
}

-(void)hideView
{
    [UIView animateWithDuration:2.0  animations:^{
        
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
   
}
@end
