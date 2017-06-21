//
//  ZLConst.h
//  IndexSortSearchDemo
//
//  Created by ZL on 2017/6/21.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLConst : NSObject


// 选择环境地址
// 是否使用测试域名
#define ZL_ISTestHostUrl 0


#if !ZL_ISTestHostUrl
#define ZL_HostUrl @"http://" // 正式环境

#else
#define ZL_HostUrl @"http://" // 测试地址

#endif


//*　-----------------------------------　*//


// 所有网络请求接口





//*　-----------------------------------　*//

// 设置尺寸
#define UI_View_Width   [UIScreen mainScreen].bounds.size.width // 屏幕宽度
#define UI_View_Height  [UIScreen mainScreen].bounds.size.height // 屏幕高度
#define UI_navBar_Height  64.0 // 导航条高度


#define ZL_btnCornerRadius 3.0 // 按钮的边框弧度


// 十六进制颜色
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// RGB颜色
#define ZLColor(r, g, b)   [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define ZLRandomColor ZLColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256)) // 随机色

#define ZLBackgroundColor  ZLColor(243, 243, 243) // 全局界面背景色
#define ZLGlobalColor  ZLColor(255, 45, 77)  // 全局基调色
#define ZLNavColor  [UIColor whiteColor]  // 导航条白色色系
#define ZLNavTitleColor    ZLGlobalColor // 导航条文字颜色
#define ZLTitleColor   ZLGlobalColor // 全局文本文字红色色系
#define ZL_textfieldColor  ZLColor(156, 156, 156) // 输入框字体颜色
#define setupTextLabelColor   ZLColor(102, 102, 102) // 设置里相关左标题黑色文字颜色
#define setupDetailTextLabelColor   ZLColor(153, 153, 153) // 设置里相关右标题灰色文字颜色
#define setupLineColor  ZLColor(243, 243, 243) // 设置里分割线颜色



// 字体
#define navTitleFont [UIFont systemFontOfSize:18] // 导航条标题文字字体
#define ZL_textfieldFont [UIFont systemFontOfSize:14] // 文本输入框文本字体
#define setupTextLabelFont [UIFont systemFontOfSize:14] // 设置里文本字号


//*　-----------------------------------　*//

// 一些缩写
#define ZLNotificationCenter  [NSNotificationCenter defaultCenter] // 通知中心

@end
