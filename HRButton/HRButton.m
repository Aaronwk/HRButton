//
//  HRButton.m
//  HRButton
//
//  Created by 王凯 on 2016/10/21.
//  Copyright © 2016年 王凯. All rights reserved.
//

#define scala 5

static float const ControlAlpha_Normal = 1;
static float const ControlAlpha_Highlighted = 0.8;

#import "HRButton.h"

@interface HRButton () {
    
    float imgX;
    float imgY;
    float imgW;
    float imgH;
    float txtX;
    float txtY;
    float txtW;
    float txtH;
    
    id _target;
    SEL _action;
}

/** 按钮类型 */
@property (assign, nonatomic) HRControlType controlType;
/** 按钮底图 */
@property (strong, nonatomic) UIImageView *controlImageView;
/** 图像 */
@property (strong, nonatomic) UIImageView *imageView;
/** 自身的宽度 */
@property (assign, nonatomic) CGFloat width;
/** 自身的高度 */
@property (assign, nonatomic) CGFloat height;
/** 按钮的图片 */
@property (strong, nonatomic) UIImage *image;
/** 按钮的标题 */
@property (copy, nonatomic) NSString *title;
/** 按钮文字控件 */
@property (strong, nonatomic) UILabel *titleLabel;
/** 按钮事件 */
@property (copy, nonatomic) ControlAction controAction;

@end

@implementation HRButton


- (UIImageView *)imageView {
    if(!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:self.imageView];
     }
   return _imageView;
}
- (UIImageView *)controlImageView {
    if(!_controlImageView) {
        _controlImageView = [[UIImageView alloc] init];
        [self addSubview:_controlImageView];
    }
    return _controlImageView;
}
- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setFont:[UIFont systemFontOfSize:15]];
        switch (self.controlType) {
            case HRControlTypeForNormal:
            {
                [_titleLabel setTextAlignment:NSTextAlignmentLeft];
            }
                break;
            case HRControlTypeForCustom:
            {
                [_titleLabel setTextAlignment:NSTextAlignmentRight];
            }
                
            default:
                break;
        }
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (void)setTitle:(NSString *)title {
    _title = title;
}
- (void)setControlImage:(UIImage *)image {
    _image = image;
    [self configUI];
}
- (void)setControlTitle:(NSString *)title {
    _title = title;
    [self configUI];
}
- (void)setClearance:(float)clearance {
    _clearance = clearance;
    switch (self.controlType) {
        case HRControlTypeForNormal:
        {
            imgX = imgX - _clearance / 2;
            txtX = txtX + _clearance / 2;
            txtW = txtW - _clearance / 2;
            if(imgX < 0) {
                imgX = 0;
            }
        }
            break;
        case HRControlTypeForCustom:
        {
            imgX = imgX + _clearance / 2;
            txtW = txtW - _clearance / 2;
        }
            break;
            
        default:
            break;
    }
    
    [self configUI];
}
- (void)setLeftSpace:(float)leftSpace {
    _leftSpace = leftSpace;
    switch (self.controlType) {
        case HRControlTypeForNormal:
        {
            imgX = _leftSpace;
        }
            break;
        case HRControlTypeForCustom:
        {
            [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
            txtX = _leftSpace;
        }
            break;
            
        default:
            break;
    }
    [self configUI];
}
- (void)setRightSpace:(float)rightSpace {
    _rightSpace = rightSpace;
    switch (self.controlType) {
        case HRControlTypeForNormal:
        {
            [self.titleLabel setTextAlignment:NSTextAlignmentRight];
            txtW = txtW - _rightSpace;
        }
            break;
        case HRControlTypeForCustom:
        {
            imgX = _width - imageWidth(_image) - _rightSpace;
        }
            break;
            
        default:
            break;
    }
    [self configUI];
}
- (void)setTxtFont:(UIFont *)txtFont {
    _txtFont = txtFont;
    [self.titleLabel setFont:_txtFont];
}
- (void)setBackgroundImage:(UIImage *)image {
    [self.controlImageView setImage:image];
}
- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    [self.controlImageView setBackgroundColor:backgroundColor];
}
- (CGRect)controlImageViewFrame {
    return CGRectMake(0, 0, _width, _height);
}
- (CGRect)imageViewFrame {
    
    switch (self.controlType) {
        case HRControlTypeForNormal:
        {
            if(imgH > _height) {
                imgH = _height;
                imgY = 0;
            }
            if(imgW > _width) {
                imgW = _width;
                imgX = 0;
            }
        }
            break;
        case HRControlTypeForCustom:
        {
            if(imgH > _height) {
                imgH = _height;
                imgY = 0;
            }
            if(imgW > _width) {
                imgW = _width;
            }
        }
            break;
            
        default:
            break;
    }
    return CGRectMake(imgX, imgY, imgW, imgH);
}
- (CGRect)titleLabelFrame {

    return CGRectMake(txtX, txtY, txtW, txtH);
}

CGFloat imageWidth (UIImage *img) {
    return img.size.width;
}
CGFloat imageHeight (UIImage *img) {
    return img.size.height;
}

- (instancetype)initWithFrame:(CGRect)frame img:(UIImage *)img txt:(NSString *)txt forControlType:(HRControlType)controlType {
    
    _image = img;
    _title = txt;
    _text = _title;
    _controlType = controlType;
    
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _width = frame.size.width;
        _height = frame.size.height;
        
        switch (self.controlType) {
            case HRControlTypeForNormal:
            {
                imgX = _width/2- imageWidth(_image);
                imgY = _height/2-imageHeight(_image)/2;
                imgW = imageWidth(_image);
                imgH = imageHeight(_image);
                txtX = _width/2;
                txtY = 0;
                txtW = _width/2;
                txtH = _height;
            }
                break;
            case HRControlTypeForCustom:
            {
                imgX = _width/2;
                imgY = 0;
                imgW = imageWidth(_image);
                imgH = imageHeight(_image);
                txtX = 0;
                txtY = 0;
                txtW = _width/2;
                txtH = _height;
            }
                break;
                
            default:
            {
                float x = frame.origin.x;
                float y = frame.origin.y;
                float w = frame.size.width;
                float h = frame.size.height;
                
                imgX = txtX = x;
                imgY = txtY = y;
                imgW = txtW = w;
                imgH = txtH = h;
                
            }
                break;
        }
        
        [self configUI];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)configUI {
    
    switch (_controlType) {
        case HRControlTypeForNormal:
        case HRControlTypeForCustom:
        {
            [self.controlImageView setFrame:[self controlImageViewFrame]];
            [self.imageView setFrame:[self imageViewFrame]];
            [self.titleLabel setFrame:[self titleLabelFrame]];
            [self.titleLabel setText:_title];
            [self.imageView setImage:_image];
        }
        default:
        {
            [self.controlImageView setFrame:[self controlImageViewFrame]];
        }
            break;
    }
    
    
}

- (void)controlSetRoundWithRadius:(CGFloat)radius {
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:radius];
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setAlpha:ControlAlpha_Normal];
    [_target performSelector:_action withObject:self];
    if(self.controAction) {
        self.controAction(self);
    }
}
#pragma clang diagnostic pop
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setAlpha:ControlAlpha_Highlighted];
}
- (void)addAction:(ControlAction)action {
    self.controAction = action;
}
- (void)addTarget:(id)target action:(SEL)action {
    _target = target;
    _action = action;
    
}




@end
