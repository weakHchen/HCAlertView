//
//  HCAlertView.m
//  HCAlertView
//
//  Created by hchen on 2017/10/30.
//  Copyright © 2017年 QZW. All rights reserved.
//

#import "HCAlertView.h"

@interface HCAlertView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *msgLabel;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSAttributedString *attrMessage;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *cancelTitle;
@property (nonatomic, strong) NSString *sureTitle;
@property (nonatomic, assign) NSTextAlignment textMent;

@property (nonatomic, strong) HCAlertViewBlock callBackBlock;

@end

@implementation HCAlertView

#pragma mark - 方法重写
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpDefault];
    }
    return self;
}

#pragma mark - 私有方法

- (instancetype)initWithTitle:(NSString*)title message:(NSString*)message textMent:(NSTextAlignment)tment cancel:(NSString*)ctitle sure:(NSString*)stitle callBack:(HCAlertViewBlock)callBack{
    self = [super init];
    if (self) {
        
        self.title = title;
        self.message = message;
        self.cancelTitle = ctitle;
        self.sureTitle = stitle;
        self.callBackBlock = callBack;
        self.textMent = tment;
        
        [self setUpDefault];
        [self setUpTitleLabel];
        [self setUpMsgLabel];
        [self setUpButtons];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString*)title attrMsg:(NSAttributedString*)attrMsg textMent:(NSTextAlignment)tment cancel:(NSString*)ctitle sure:(NSString*)stitle callBack:(HCAlertViewBlock)callBack{
    
    self.title = title;
    self.attrMessage = attrMsg;
    self.cancelTitle = ctitle;
    self.sureTitle = stitle;
    self.callBackBlock = callBack;
    self.textMent = tment;
    
    [self setUpDefault];
    [self setUpTitleLabel];
    [self setUpMsgLabel_AttrMessage];
    [self setUpButtons];
    
    return self;
}

/**
 默认contentView设置
 */
- (void)setUpDefault{
    self.frame = CGRectMake(0, 0, _width, _height);
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.backgroundColor = _colorDefault;
    [self addSubview:self.contentView];
}

/**
 标题设置
 */
- (void)setUpTitleLabel{
    if (![self isEmptyString:self.title]) {
        self.titleLabel.text = self.title;
        self.titleLabel.font = _fontTitle;
        self.titleLabel.textColor = _fontColor_title;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.titleLabel sizeToFit];
        CGFloat centerX = _contentWidth/2;
        CGFloat centerY = _contentWidth*_ratio*0.25/2;
        self.titleLabel.center = CGPointMake(centerX, centerY);
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, _contentWidth*_ratio*0.25, _contentWidth, 0.5)];
        line.backgroundColor = _lineColor;
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:line];
    }
}


/**
 消息设置
 */
- (void)setUpMsgLabel{
    CGFloat width = _contentWidth - 2*_padding;
    CGFloat height = _contentWidth*_ratio - _contentWidth*_ratio*0.25;
    CGFloat top = 0;
    if (![self isEmptyString:self.title]) {
        height = height - _contentWidth*_ratio*0.25;
        top = _contentWidth*_ratio*0.25;
    }
    self.msgLabel.font = _fontMsg;
    self.msgLabel.textColor = _fontColor_msg;
    self.msgLabel.text = self.message;
    self.msgLabel.textAlignment = self.textMent;
    [self.msgLabel sizeToFit];
    CGSize maxSize = self.msgLabel.frame.size;
    
    self.msgLabel.frame = CGRectMake(_padding, (height-maxSize.height)/2+top, width, maxSize.height);
    [self.contentView addSubview:self.msgLabel];
    NSLog(@"height:%f",height);
    NSLog(@"_contentWidth*_ratio:%f",_contentWidth*_ratio);
    NSLog(@"maxSize.height:%f",maxSize.height);
    NSLog(@"(height-maxSize.height)/2:%f",(height-maxSize.height)/2);
}

- (void)setUpMsgLabel_AttrMessage{
    CGFloat width = _contentWidth - 2*_padding;
    CGFloat height = _contentWidth*_ratio - _contentWidth*_ratio*0.25;
    CGFloat top = 0;
    if (![self isEmptyString:self.title]) {
        height = height - _contentWidth*_ratio*0.25;
        top = _contentWidth*_ratio*0.25;
    }
    self.msgLabel.font = _fontMsg;
    self.msgLabel.textColor = _fontColor_msg;
    self.msgLabel.attributedText = self.attrMessage;
    self.msgLabel.textAlignment = self.textMent;
    [self.msgLabel sizeToFit];
    CGSize maxSize = self.msgLabel.frame.size;
    
    self.msgLabel.frame = CGRectMake(_padding, (height-maxSize.height)/2+top, width, maxSize.height);
    [self.contentView addSubview:self.msgLabel];
    NSLog(@"height:%f",height);
    NSLog(@"_contentWidth*_ratio:%f",_contentWidth*_ratio);
    NSLog(@"maxSize.height:%f",maxSize.height);
    NSLog(@"(height-maxSize.height)/2:%f",(height-maxSize.height)/2);
}


/**
 按钮设置
 */
- (void)setUpButtons{
    CGFloat width = _contentWidth;
    CGFloat height = _contentWidth*_ratio*0.25;
    
    CGFloat left = 0;
    CGFloat top = _contentWidth*_ratio-height;
    
    if (![self isEmptyString:self.cancelTitle]) {
        width = width/2;
        left = width;
    }
    UIButton *cancel = [self _buttonFrame:CGRectMake(0, top, width, height) tag:_baseTag
                                    title:self.cancelTitle color:_color_buttonGray target:self action:@selector(buttonClick:)];
    UIButton *sure = [self _buttonFrame:CGRectMake(left, top, width, height) tag:_baseTag+1
                                  title:self.sureTitle color:_color_buttonBule target:self action:@selector(buttonClick:)];
    
    if (![self isEmptyString:self.cancelTitle]) {
        [self.contentView addSubview:cancel];
    }
    [self.contentView addSubview:sure];
}


/**
 按钮点击方法
 */
- (void)buttonClick:(UIButton *)sender{
    if (_callBackBlock) {
        _callBackBlock(self, sender.tag-_baseTag);
    }
    [self dismiss];
}

/**
 创建按钮
 */
- (UIButton *)_buttonFrame:(CGRect)frame tag:(NSInteger)tag title:(NSString*)title color:(UIColor*)color target:(nullable id)target action:(nonnull SEL)action{
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = frame;
    _button.tag = tag;
    [_button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [_button setTitle:title forState:UIControlStateNormal];
    [_button setTitleColor:color forState:UIControlStateNormal];
    UIView *up = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0.5)];
    up.backgroundColor = _lineColor;
    UIView *right = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width, 0, 0.5, frame.size.height)];
    right.backgroundColor = _lineColor;
    [_button addSubview:up];
    [_button addSubview:right];
    
    return _button;
}

/**
 判断字符串是否为空 空return YES
 */
- (BOOL)isEmptyString:(NSString*)string{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[NSString stringWithFormat:@"%@",string] length]==0) {
        return YES;
    }
    return NO;
}

#pragma mark - 显示和移除
- (void)show{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
    [self animationWithView:_contentView duration:_duration];
}

- (void)dismiss{
    [UIView animateWithDuration:_duration
                     animations:^{
                         self.alpha = 0;
                         self.contentView.alpha = 0;
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

#pragma mark - show动画
- (void)animationWithView:(UIView *)view duration:(CFTimeInterval)duration{
    
    [UIView animateWithDuration:duration-0.1 animations:^{
        self.backgroundColor = _color;
    }];
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.1)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [view.layer addAnimation:animation forKey:nil];
}

#pragma mark - 懒加载

- (UILabel *)msgLabel{
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(_padding, 0, _contentWidth-2*_padding, 0)];
        _msgLabel.numberOfLines = 0;
    }
    return _msgLabel;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_padding, 0, _contentWidth-2*_padding, 0)];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _contentWidth, _contentWidth * _ratio)];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.center = self.center;
        _contentView.layer.cornerRadius = _cornerRadius;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}
#pragma mark - open方法

+ (void)alertWithTitle:(NSString *)title message:(NSString *)msg textMent:(NSTextAlignment)tment cancel:(NSString *)ctitle sure:(NSString *)stitle callBack:(HCAlertViewBlock)callBack{
    HCAlertView *alert = [[HCAlertView alloc] initWithTitle:title message:msg textMent:tment cancel:ctitle sure:stitle callBack:callBack];
    [alert show];
}

+ (void)alertWithTitle:(NSString *)title attrMsg:(NSAttributedString *)attrMsg textMent:(NSTextAlignment)tment cancel:(NSString *)ctitle sure:(NSString *)stitle callBack:(HCAlertViewBlock)callBack{
    HCAlertView *alert = [[HCAlertView alloc] initWithTitle:title attrMsg:attrMsg textMent:tment cancel:ctitle sure:stitle callBack:callBack];
    [alert show];
}
@end
