//
//  ViewController.m
//  IndexSortSearchDemo
//
//  Created by ZL on 2017/6/21.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "ViewController.h"
#import "ZLInventoryDetailsController.h"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 实现一个跳转入口而已~
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"进入测试" forState:UIControlStateNormal];
    btn.frame = CGRectMake(15, 100, UI_View_Width - 15 * 2, 40);
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [btn addTarget:self action:@selector(btnPress) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = ZLColor(255, 45, 77);
    btn.titleLabel.textColor = [UIColor whiteColor];
    btn.layer.cornerRadius = ZL_btnCornerRadius;
    btn.clipsToBounds = YES;
    [self.view addSubview:btn];
}

- (void)btnPress {
    
    ZLInventoryDetailsController *vc = [[ZLInventoryDetailsController alloc] init];
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
