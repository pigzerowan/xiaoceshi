//
//  DMBaseTableView.m
//  GoodChilds
//
//  Created by apple on 16/7/21.
//  Copyright © 2016年 duanmu. All rights reserved.
//

#import "DMBaseTableView.h"
#import "DMDefine.h"
@interface DMBaseTableView ()

@end

@implementation DMBaseTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.m_tableView];
    // Do any additional setup after loading the view.
}

-(UITableView *)m_tableView
{
    if (!_m_tableView) {
        _m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENALLHEIGHT)  style:UITableViewStylePlain];
        _m_tableView.showsVerticalScrollIndicator = NO;
        _m_tableView.backgroundColor = [UIColor clearColor];
        _m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _m_tableView;
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
