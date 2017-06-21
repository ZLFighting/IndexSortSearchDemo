//
//  ZLGoodsModel.h
//  IndexSortSearchDemo
//
//  Created by ZL on 2017/6/21.
//  Copyright © 2017年 ZL. All rights reserved.
//  商品 Model

#import <Foundation/Foundation.h>

@interface ZLGoodsModel : NSObject

// id标识
@property (nonatomic, copy) NSString *id;

// 商品名称
@property (nonatomic, copy) NSString *name;

// 库存成本
@property (nonatomic, assign) float cost;

// 库存数量
@property (nonatomic, assign) NSInteger num;

//+ (NSArray *)loadGoodsInfoFromJson:(NSArray *)array;

@end
