//
//  DrawCircle.m
//  drawRadar
//
//  Created by dllo on 16/4/7.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "DrawCircle.h"
@interface DrawCircle ()

@end

@implementation DrawCircle

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatLabelCenter];
    }
    return self;
}

- (void)creatLabelCenter{
    self.centerLabel = [[UILabel alloc] init];
    self.centerLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.centerLabel];
    self.buttomLabel = [[UILabel alloc] init];
    self.buttomLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.buttomLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.centerLabel.frame = CGRectMake(0, 0, self.frame.size.width / 10 * 7, self.frame.size.width / 10 * 7 / 3 * 2);
    self.centerLabel.font = [UIFont systemFontOfSize:12 * self.frame.size.width / 10 * 2 / 15];
    self.centerLabel.center = CGPointMake(self.frame.size.width / 10 * 7 / 2 + self.frame.size.width / 10 * 3 / 2, self.frame.size.width / 10 * 7 / 2 + self.frame.size.width / 10 * 3 / 4);
    self.buttomLabel.frame = CGRectMake(0, 0, self.frame.size.width / 10 * 7, self.frame.size.width / 10 * 2);
    self.buttomLabel.center = CGPointMake(self.frame.size.width / 10 * 7 / 2 + self.frame.size.width / 10 * 3 / 2, self.frame.size.width / 10 * 9);
    self.buttomLabel.font = [UIFont systemFontOfSize:10 * self.frame.size.width / 10 * 2 / 15];
}

- (void)drawRect:(CGRect)rect{
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.frame.size.width / 10 * 3 / 2  , self.frame.size.width / 10 * 3 / 4, self.frame.size.width / 10 * 7, self.frame.size.width / 10 * 7)];
    circle.lineWidth = 1.5;
    [[UIColor colorWithRed:241.f / 255.f green:242.f / 255.f blue:243.f / 255.f alpha:0.8] setStroke];
    [circle stroke];
    CGPoint circleCenter = CGPointMake(self.frame.size.width / 10 * 7 / 2 + self.frame.size.width / 10 * 3 / 2, self.frame.size.width / 10 * 7 / 2 + self.frame.size.width / 10 * 3 / 4);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:circleCenter radius:self.frame.size.width / 10 * 7 / 2 startAngle:3 * M_PI / 2 endAngle:3 * M_PI / 2 + 2 * M_PI * self.rate clockwise:YES];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 1.5;
    [[UIColor colorWithRed:7.f / 255.f green:124.f / 255.f blue:209.f / 255.f alpha:1] setStroke];
    [path stroke];
}

@end
