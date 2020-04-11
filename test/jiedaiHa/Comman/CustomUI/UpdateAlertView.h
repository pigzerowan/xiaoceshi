//
//  UpdateAlertView.h
//  GoodChilds
//
//  Created by apple on 2016/11/11.
//  Copyright © 2016年 duanmu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateAlertView : UIView
@property (weak, nonatomic) IBOutlet UIView *view;

-(id)initWithMessage:(NSString *)message ;
- (IBAction)closeClick:(id)sender;
- (IBAction)commitClick:(id)sender;
-(void)showWithCompletion:(void (^)(NSInteger selectIndex))completeBlock;
-(void)hideView;
@end
