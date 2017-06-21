//
//  ZLTInventoryDetailsCell.h
//  IndexSortSearchDemo
//
//  Created by ZL on 2017/6/21.
//  Copyright © 2017年 ZL. All rights reserved.
//  库存详情

#import <UIKit/UIKit.h>
@class ZLGoodsModel;

#define ZLInventoryDetailsCellHeight  60.0

@interface ZLInventoryDetailsCell : UITableViewCell

@property (strong, nonatomic) ZLGoodsModel *model;

// 创建并返回cell
+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
