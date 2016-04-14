//
//  Radar.m
//  drawRadar
//
//  Created by dllo on 16/3/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "Radar.h"

@implementation Radar

- (instancetype)initWithCenter:(CGPoint)center Parameter:(Parameter)radarParmeter Width:(CGFloat)width FigureCount:(NSInteger)figurecount MaxParmeter:(CGFloat)maxParmeter{
    self = [super init];
    if (self) {
        CGFloat height = (width / figurecount) * (width / figurecount) - (width / (2 * figurecount)) * (width / (2 * figurecount));
        self.radarParmeter = radarParmeter;
        self.width = width;
        self.count = figurecount;
        self.maxParmeter = maxParmeter;
        self.frame = CGRectMake(0, 0, 2 * width, figurecount * sqrt(height) * 2);
        self.center = center;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self creatRadarMaxwidth:self.width Count:self.count];
    [self creatRadarfillWidth:self.width Parameter:self.radarParmeter  Maxparameter:self.maxParmeter Count:self.count];
}

- (void)creatRadarMaxwidth:(CGFloat)width Count:(NSInteger)count{
    CGFloat height = (width / count) * (width / count) - (width / (2 * count)) * (width / (2 * count));
    for (int i = 0; i < count; i++) {
        UIBezierPath *line = [UIBezierPath bezierPath];
        
        [line moveToPoint:CGPointMake(0 + width / count * i,count * sqrt(height))];
        [line addLineToPoint:CGPointMake(width / 2 + width / (count * 2) * i, 0 + i * sqrt(height))];
        [line addLineToPoint:CGPointMake(width * 1.5 -  width / (count * 2) * i, 0 + i * sqrt(height))];
        [line addLineToPoint:CGPointMake(2 * width - width / count * i, count * sqrt(height))];
        [line addLineToPoint:CGPointMake(width * 1.5 -  width / (count * 2) * i, 2 * count * sqrt(height) - sqrt(height) * i)];
        [line addLineToPoint:CGPointMake(width / 2 + width / (2 * count) * i, 2 * count * sqrt(height) - sqrt(height) * i)];
        [line addLineToPoint:CGPointMake(0 + width / count * i,count * sqrt(height))];
        [line closePath];
        line.lineWidth = 1;
        [[UIColor lightGrayColor] setStroke];
        [line stroke];
    }
    UIBezierPath *cutline = [UIBezierPath bezierPath];
    [cutline moveToPoint:CGPointMake(0,count * sqrt(height))];
    [cutline addLineToPoint:CGPointMake(2 * width, count * sqrt(height))];
    [cutline addLineToPoint:CGPointMake(width * 1.5, 2 * count * sqrt(height))];
    [cutline addLineToPoint:CGPointMake(width / 2, 0)];
    [cutline addLineToPoint:CGPointMake(width * 1.5 , 0)];
    [cutline addLineToPoint:CGPointMake(width / 2, 2 * count * sqrt(height))];
    [cutline closePath];
    cutline.lineWidth = 1;
    [[UIColor lightGrayColor] setStroke];
    [cutline stroke];
}
- (void)creatRadarfillWidth:(CGFloat)width Parameter:(Parameter)paramater Maxparameter:(CGFloat)max Count:(NSInteger)count{
    CGFloat height = (width / count) * (width / count) - (width / (2 * count)) * (width / (2 * count));
    UIBezierPath *line = [UIBezierPath bezierPath];

    [line moveToPoint:CGPointMake(width - paramater.left / max * width, count * sqrt(height))];
    [line addLineToPoint:CGPointMake(width - width / 2 * (paramater.left_top / max),sqrt(height) * count - sqrt(height) * count * (paramater.left_top / max))];
    [line addLineToPoint:CGPointMake(width + (paramater.right_top / max) * width / 2, sqrt(height) * count - sqrt(height) * count * (paramater.right_top / max))];
    [line addLineToPoint:CGPointMake(width + paramater.right / max * width, count * sqrt(height))];
    [line addLineToPoint:CGPointMake(width / 2 * (paramater.right_bottom / max) + width, sqrt(height) * count * (paramater.right_bottom / max) + sqrt(height) * count)];
    [line addLineToPoint:CGPointMake(width - (paramater.left_bottom / max) * width / 2, sqrt(height) * count * (paramater.left_bottom / max) + sqrt(height) * count)];
    [line addLineToPoint:CGPointMake(width - paramater.left / max * width, count * sqrt(height))];
    [line closePath];
    line.lineWidth = 1;
    // 边框颜色
    [[UIColor colorWithRed:0 green:81.f / 255.f blue:127.f/ 255.f alpha:0.7] setStroke];
    // 填充颜色
    [[UIColor colorWithRed:0 green:193.f / 255.f blue:246.f / 255.f alpha:0.3] setFill];
    [line fill];
    [line stroke];
}

@end
