//
//  EnterForVC.m
//  jiedaiHa
//
//  Created by 郑渊文 on 2017/4/11.
//  Copyright © 2020年 transfar. All rights reserved.
//

#import "EnterForVC.h"
#import "MessageModel.h"
#import "MessageRequestViewModel.h"
#import "SVPullToRefresh.h"
#import "MessageTabDelegate.h"
#import "MessageTabDatasource.h"
#import "DMNetworking.h"
@interface EnterForVC ()
@property(nonatomic,strong)MessageTabDelegate *m_tabDelegate;
@property(nonatomic,strong)MessageTabDatasource *m_tabDataSource;
@property(nonatomic,strong)MessageRequestViewModel *activityRequestViewModel;
@property(nonatomic,strong)UITableView *m_tableView;

@end

@implementation EnterForVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    self.view.backgroundColor = [UIColor whiteColor];
    


    UIBarButtonItem *myButton = [[UIBarButtonItem alloc] initWithTitle:@"创建消息" style:UIBarButtonItemStyleBordered target:self action:@selector(clickEvent)];

    self.navigationItem.rightBarButtonItem = myButton;

    
    self.m_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENALLHEIGHT) style:UITableViewStyleGrouped];
    [self.m_tableView registerNib:[UINib nibWithNibName:@"MessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"MessageTableViewCell"];

    [self.view addSubview:self.m_tableView];
    self.m_tableView.dataSource = self.m_tabDataSource;
    self.m_tableView.delegate= self.m_tabDelegate;

    [self loadRequest];


    @weakify(self);

    [RACObserve(self.activityRequestViewModel, catches) subscribeNext:^(NSArray *arr) {
        @strongify(self);
        self.m_tabDataSource.m_arr = arr;
        self.m_tabDelegate.m_arr = arr;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.m_tableView reloadData];
        });

        if (self.activityRequestViewModel.catches.count >= 10) {
            // infinite scrolling
            [self.m_tableView addInfiniteScrollingWithActionHandler:^{
                @strongify(self);
                [self.activityRequestViewModel.infiniteScrollCommand execute:nil];
            }];
        }
        [self.m_tableView.pullToRefreshView stopAnimating];
        [self.m_tableView.infiniteScrollingView stopAnimating];
    }];
    [self.activityRequestViewModel.moreObject subscribeNext:^(NSArray *moremodel) {
        @strongify(self);
        if (moremodel.count< 10) {
            self.m_tableView.showsInfiniteScrolling = NO;
        }else{
            self.m_tableView.showsInfiniteScrolling = YES;
        }
    }];
    // Pull to refresh
    [self.m_tableView addPullToRefreshWithActionHandler:^{
        @strongify(self);

        [self loadRequest];
    }];

    // Do any additional setup after loading the view, typically from a nib.
}
-(void)loadRequest
{
    [[self.activityRequestViewModel.pullToRefreshCommand execute:nil] subscribeNext:^(id x) {
        
    } error:^(NSError *error) {
        //在这里来接收网络请求失败的情况
//        [self showError:error];
        [self.m_tableView.pullToRefreshView stopAnimating];
        
    }];
    
}
#pragma mark -- 懒加载
-(MessageTabDelegate *)m_tabDelegate
{
    if (!_m_tabDelegate) {
        _m_tabDelegate = [[MessageTabDelegate alloc]init];
    }
    return _m_tabDelegate;
}
                                                                
-(MessageTabDatasource *)m_tabDataSource
{
    if (!_m_tabDataSource) {
        _m_tabDataSource = [[MessageTabDatasource alloc]init];
    }
    return _m_tabDataSource;
}
-(MessageRequestViewModel *)activityRequestViewModel
{
    if (!_activityRequestViewModel) {
        _activityRequestViewModel = [[MessageRequestViewModel alloc]init];
        
    }
    return _activityRequestViewModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)clickEvent
{
    NSString *timeStr = [NSString stringWithFormat:@"消息%@",[self getNowTimeTimestamp]];
    
    [DMNetworking postWithUrl:@"https://3evjrl4n5d.execute-api.us-west-1.amazonaws.com/dev/message" params:@{@"id":@"10",@"content":timeStr} success:^(id response) {
        NSLog(@"=========%@",response);
    } fail:^(NSError *error) {
        
    } showHUD:NO];
}

-(NSString *)getNowTimeTimestamp{

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式

    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970]*1000)];

    return timeSp;
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
