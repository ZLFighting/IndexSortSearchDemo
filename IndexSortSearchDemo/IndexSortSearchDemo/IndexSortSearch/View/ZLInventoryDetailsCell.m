//
//  ZLTInventoryDetailsCell.m
//  IndexSortSearchDemo
//
//  Created by ZL on 2017/6/21.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "ZLInventoryDetailsCell.h"
#import "ZLGoodsModel.h"

@interface ZLInventoryDetailsCell ()


// 背景整体
@property (nonatomic, weak) UIView *bgView;

// cell分割线条 高1
@property (nonatomic, weak) UIView *marginView;

// 商品名称
@property (nonatomic, weak) UILabel *name;

// 库存成本
@property (nonatomic, weak) UILabel *cost;

// 库存数量
@property (nonatomic, weak) UILabel *num;

@end

@implementation ZLInventoryDetailsCell

// 创建并返回cell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"ZLTInventoryDetails_cell";
    
    ZLInventoryDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[ZLInventoryDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
    
}

// 重写init方法 设置子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        // 背景整体
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        self.bgView = bgView;
        
        // 商品名称
        UILabel *name = [[UILabel alloc] init];
        name.backgroundColor = [UIColor clearColor];
        name.font = [UIFont systemFontOfSize:14];
        name.textColor = ZLColor(102, 102, 102);
        [self.bgView addSubview:name];
        self.name = name;
        
        // 库存成本
        UILabel *cost = [[UILabel alloc] init];
        cost.backgroundColor = [UIColor clearColor];
        cost.font = [UIFont systemFontOfSize:12];
        cost.textColor = ZLColor(153, 153, 153);
        [self.bgView addSubview:cost];
        self.cost = cost;
        
        // 库存数量
        UILabel *num = [[UILabel alloc] init];
        num.backgroundColor = [UIColor clearColor];
        num.font = [UIFont systemFontOfSize:12];
        num.textColor = ZLColor(153, 153, 153);
        [self.bgView addSubview:num];
        self.num = num;
        
        // cell分割线
        UIView *marginView = [[UIView alloc] init];
        marginView.backgroundColor = ZLColor(243, 243, 243);
        [self.contentView addSubview:marginView];
        self.marginView = marginView;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置子控件位置
    [self setupFrame];
}

// 设置子控件位置
- (void)setupFrame {
    
    // 顶部cell分割线条 高1
    CGFloat marginViewH = 1;
    // 左右的间隔
    CGFloat marginL = 15;
    
    CGFloat width = UI_View_Width - 2 * marginL;
    CGFloat height = ZLInventoryDetailsCellHeight - marginViewH;
    
    self.bgView.frame = CGRectMake(marginL, marginViewH, width, height);
    
    self.name.frame = CGRectMake(0, 0, width, 30);
    
    self.num.frame = CGRectMake(0, CGRectGetMaxY(self.name.frame) + 5, width * 0.5, 20);
    
    self.cost.frame = CGRectMake(CGRectGetMaxX(self.num.frame), self.num.y, width * 0.5, self.num.height);
    
    self.marginView.frame = CGRectMake(0, height, UI_View_Width, marginViewH);
}

// model赋值
- (void)setModel:(ZLGoodsModel *)model {
    
    _model = model;
    
    // 商品名称
    self.name.text = [NSString stringWithFormat:@"%@", model.name];
    
    // 库存数量
    self.num.text = [NSString stringWithFormat:@"库存%ld", (long)model.num];
    
    // 库存成本
    self.cost.text = [NSString stringWithFormat:@"成本%.2f", model.cost];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
