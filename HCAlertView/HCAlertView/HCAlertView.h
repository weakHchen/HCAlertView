//
//  HCAlertView.h
//  HCAlertView
//
//  Created by hchen on 2017/10/30.
//  Copyright © 2017年 QZW. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HCAlertView;
typedef void (^HCAlertViewBlock)(HCAlertView *alert, NSInteger index);

#define _width  [UIScreen mainScreen].bounds.size.width // 屏幕宽度
#define _height [UIScreen mainScreen].bounds.size.height // 屏幕高度
#define _contentWidth ([UIScreen mainScreen].bounds.size.width-60) // 内容视图宽度
#define _ratio  0.65 // 内容视图宽高比
#define _cornerRadius 10 // cornerRadius
#define _colorDefault [UIColor colorWithWhite:0.2f alpha: 0] // self 颜色和透明度 (动画开始默认) - | ==>为保障self设置alpha时
#define _color [UIColor colorWithWhite:0.2f alpha: 0.5] // self 颜色和透明度 (动画结束颜色)      - | ==>不影响子视图的透明度
#define _duration 0.3 // 动画时间
#define _baseTag 10000

// content 子视图字体大小和颜色
#define _padding 20 // 控件距contentView 距离
#define _fontTitle  [UIFont fontWithName:@"Helvetica Neue" size:20.f]
#define _fontMsg    [UIFont fontWithName:@"Helvetica Neue" size:17.f]
#define _fontColor_title        [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1]
#define _fontColor_msg          [UIColor colorWithRed:102/255.f green:102/255.f blue:102/255.f alpha:1]
#define _color_buttonGray   [UIColor colorWithRed:153/255.f green:153/255.f blue:153/255.f alpha:1]
#define _color_buttonBule   [UIColor colorWithRed:74/255.f green:149/255.f blue:252/255.f alpha:1]

#define _lineColor [UIColor colorWithRed:219.0/255 green:219.0/255 blue:219.0/255 alpha:1.0]

@interface HCAlertView : UIView


/**
 显示HCAlertView NSString *message

 @param title 标题
 @param msg 消息
 @param tment NSTextAlignment 左中右
 @param ctitle 取消按钮标题(非必须->不传只显示一个)
 @param stitle 确定按钮标题(必须)
 @param callBack 回调(根据index判断)
 */
+ (void)alertWithTitle:(NSString*)title message:(NSString*)msg textMent:(NSTextAlignment)tment cancel:(NSString*)ctitle sure:(NSString*)stitle callBack:(HCAlertViewBlock)callBack;

/**
 显示HCAlertView NSAttributedString *message
 
 @param title 标题
 @param attrMsg 消息
 @param tment NSTextAlignment 左中右
 @param ctitle 取消按钮标题(非必须->不传只显示一个)
 @param stitle 确定按钮标题(必须)
 @param callBack 回调(根据index判断)
 */
+ (void)alertWithTitle:(NSString *)title attrMsg:(NSAttributedString *)attrMsg textMent:(NSTextAlignment)tment cancel:(NSString *)ctitle sure:(NSString *)stitle callBack:(HCAlertViewBlock)callBack;

@end
