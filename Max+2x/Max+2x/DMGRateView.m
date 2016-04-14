//
//  DMGRateView.m
//  drawRadar
//
//  Created by dllo on 16/4/7.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "DMGRateView.h"

@implementation DMGRateView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:209.f / 255.f green:215.f / 255.f blue:219.f / 255.f alpha:0.7];
        self.colorView = [[UIView alloc] init];
        self.colorView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.colorView];
        self.gradientLayer = [CAGradientLayer layer];
        [self.colorView.layer addSublayer:self.gradientLayer];
        self.gradientLayer.startPoint = CGPointMake(0, 0);
        self.gradientLayer.endPoint = CGPointMake(1, 0);
        self.gradientLayer.locations = @[@(0.25f) ,@(1.0f)];
        self.textLabel = [[UILabel alloc] init];
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.textLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.colorView.frame = CGRectMake(0, 0, self.frame.size.width * self.rate, self.frame.size.height);
    self.gradientLayer.colors = @[(__bridge id)self.sColor.CGColor,(__bridge id)self.eColor.CGColor];
    self.gradientLayer.frame = self.colorView.frame;
    self.textLabel.frame = CGRectMake(10, 0, self.frame.size.width, self.frame.size.height);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    
//}


@end
