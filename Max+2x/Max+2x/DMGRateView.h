//
//  DMGRateView.h
//  drawRadar
//
//  Created by dllo on 16/4/7.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMGRateView : UIView

@property (nonatomic, retain) UILabel *textLabel;

@property (nonatomic, retain) UIView *colorView;

@property (nonatomic, retain) CAGradientLayer *gradientLayer;

@property (nonatomic, assign) CGFloat rate;

@property (nonatomic, retain) UIColor *sColor;

@property (nonatomic, retain) UIColor *eColor;

- (instancetype)initWithFrame:(CGRect)frame;

@end
