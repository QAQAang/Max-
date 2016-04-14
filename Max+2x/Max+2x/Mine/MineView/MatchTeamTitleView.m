//
//  MatchTeamTitleView.m
//  Max+2x
//
//  Created by dllo on 16/4/6.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "MatchTeamTitleView.h"

@interface MatchTeamTitleView ()

@end

@implementation MatchTeamTitleView

- (instancetype)initWithFrame:(CGRect)frame DrawColor:(UIColor *)drawColor{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleColor = drawColor;
        self.backgroundColor = [UIColor whiteColor];
        [self creatTitle];
    }
    return self;
}

- (void)creatTitle{
    self.winLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 75, 40)];
    self.winLabel.font = [UIFont systemFontOfSize:14];
    self.winLabel.textColor = [UIColor whiteColor];
    self.winLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.winLabel];
    self.informationLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 185, 10, 175, 30)];
    self.informationLabel.font = [UIFont systemFontOfSize:11];
    self.informationLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:self.informationLabel];
}

- (void)drawRect:(CGRect)rect{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width, 0)];
    [path addLineToPoint:CGPointMake(100, 0)];
    [path addLineToPoint:CGPointMake(75, 40)];
    [path addLineToPoint:CGPointMake(0, 40)];
    [path addLineToPoint:CGPointMake(0, 0)];
    [path closePath];
    path.lineWidth = 8;
    [self.titleColor setStroke];
    [self.titleColor setFill];
    [path stroke];
    [path fill];
}

@end
