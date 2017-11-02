# HCAlertView


显示HCAlertView NSString *message
@param title 标题
@param msg 消息
@param tment NSTextAlignment 左中右
@param ctitle 取消按钮标题(非必须->不传只显示一个)
@param stitle 确定按钮标题(必须)
@param callBack 回调(根据index判断)
+ (void)alertWithTitle:(NSString*)title message:(NSString*)msg textMent:(NSTextAlignment)tment cancel:(NSString*)ctitle sure:(NSString*)stitle callBack:(HCAlertViewBlock)callBack;


显示HCAlertView NSAttributedString *message
@param title 标题
@param attrMsg 消息
@param tment NSTextAlignment 左中右
@param ctitle 取消按钮标题(非必须->不传只显示一个)
@param stitle 确定按钮标题(必须)
@param callBack 回调(根据index判断)
+ (void)alertWithTitle:(NSString *)title attrMsg:(NSAttributedString *)attrMsg textMent:(NSTextAlignment)tment cancel:(NSString *)ctitle sure:(NSString *)stitle callBack:(HCAlertViewBlock)callBack;


使用
[HCAlertView alertWithTitle:@"HCAlertView" message:@"测试测试测试测试测试\n测试测试测试测试测试测试\n测试测试测试测试测试测试测试"
textMent:NSTextAlignmentLeft cancel:nil sure:@"我知道了"
callBack:^(HCAlertView *alert, NSInteger index) {
NSLog(@"%ld", (long)index);
}];

[HCAlertView alertWithTitle:@"HCAlertView" message:@"测试测试测试测试测试\n测试测试测试测试测试测试\n测试测试测试测试测试测试测试"
textMent:NSTextAlignmentLeft cancel:@"取消" sure:@"确定"
callBack:^(HCAlertView *alert, NSInteger index) {
NSLog(@"%ld", (long)index);
}];

NSString *message = @"我是attrMessage\n测试测试测试测试测试测试\n测试测试测试测试测试测试测试";
NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:message];
[attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(message.length-14, 14)];
[HCAlertView alertWithTitle:@"HCAlertView" attrMsg:attr
textMent:NSTextAlignmentCenter cancel:nil sure:@"我知道了"
callBack:^(HCAlertView *alert, NSInteger index) {
NSLog(@"%ld", (long)index);
}];
