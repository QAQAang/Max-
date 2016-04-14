//
//  SummaryView.m
//  Max+2x
//
//  Created by dllo on 16/3/28.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "SummaryView.h"

@implementation SummaryView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.textLabelCount = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width / 4, 25)];
        self.textLabelCount.font = [UIFont systemFontOfSize:20];
        self.textLabelCount.textAlignment = 1;
        self.textLabelCount.textColor = [UIColor colorWithRed:45 / 255.0 green:56 / 255.0 blue:65 / 255.0 alpha:1.000];
        [self addSubview:self.textLabelCount];
        self.textLabelType = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, [UIScreen mainScreen].bounds.size.width / 4, 15)];
        self.textLabelType.font = [UIFont systemFontOfSize:14];
        self.textLabelType.textColor = [UIColor colorWithRed:145 / 255.0 green:176 / 255.0 blue:205 / 255.0 alpha:0.8];
        self.textLabelType.textAlignment = 1;
        [self addSubview:self.textLabelType];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
