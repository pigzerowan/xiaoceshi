//
//  MessageTabDatasource.m
//  jiedaiHa
//
//  Created by 郑渊文 on 2020/4/11.
//  Copyright © 2020 transfar. All rights reserved.
//

#import "MessageTabDatasource.h"
#import "MessageTableViewCell.h"
@implementation MessageTabDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_arr.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"MessageTableViewCell";
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    ActivityListResultModel  *listData = self.m_arr[indexPath.row];
    cell.cellData = listData;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
