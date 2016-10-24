//
//  HRButton.h
//  HRButton
//
//  Created by 王凯 on 2016/10/21.
//  Copyright © 2016年 王凯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HRControlType){
    HRControlTypeForNormal, // 默认布局（图片 - 文字）
    HRControlTypeForCustom  // 设置布局（文字 - 图片）
};
/** ActionBlock */
typedef void(^ControlAction) (id obj);


@interface HRButton : UIControl

/** 按钮的文字 */
@property (copy, nonatomic,readonly) NSString *text;

/** 设置图片与文字之间的距离 - 此属性不可与 leftSpace、 rightSpace 同时使用*/
@property (assign, nonatomic) float clearance;

/** 设置左侧控件距离左侧距离 - 此属性不可与 clearance 同时使用 */
@property (assign, nonatomic) float leftSpace;

/** 设置右侧控件距离右侧距离 - 此属性不可与 clearance 同时使用 */
@property (assign, nonatomic) float rightSpace;

/** 设置文字的Font */
@property (strong, nonatomic) UIFont *txtFont;



/**
 初始化一个HRButton控件

 @param frame       控件的frame
 @param img         图片
 @param txt         文字
 @param controlType 类型
 
 */
- (instancetype)initWithFrame:(CGRect)frame img:(UIImage *)img txt:(NSString *)txt forControlType:(HRControlType)controlType;

/**
 调用此方法设置控件的背景图片

 @param image 图片
 */
- (void)setBackgroundImage:(UIImage *)image;

/**
 设置控件的图片

 @param image 图片
 */
- (void)setControlImage:(UIImage *)image;
- (void)setControlTitle:(NSString *)title;

/**
 点击方法 - target:action:
 */
- (void)addTarget:(id)target action:(SEL)action;

/**
 点击方法 - Block
 */
- (void)addAction:(ControlAction)action;

/**
 可以调用当前方法，设置控件的圆角

 @param radius 弧度
 */
- (void)controlSetRoundWithRadius:(CGFloat)radius;





@end
