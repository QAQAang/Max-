//
//  SkipView.m
//  Max+2x
//
//  Created by dllo on 16/3/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "SkipView.h"

@implementation SkipView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 60, 20)];
        self.textLabel.textColor = [UIColor lightGrayColor];
        self.textLabel.alpha = 0.8;
        self.textLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.textLabel];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(85, 5)];
    [bezierPath addLineToPoint:CGPointMake(90, 10)];
    [bezierPath addLineToPoint:CGPointMake(85, 15)];
    bezierPath.lineWidth = 1;
    [[UIColor lightGrayColor] setStroke];
    [bezierPath stroke];
}


@end
