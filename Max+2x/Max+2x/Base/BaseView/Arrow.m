//
//  Arrow.m
//  Max+2x
//
//  Created by dllo on 16/3/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "Arrow.h"

@implementation Arrow



- (void)drawRect:(CGRect)rect {
    UIBezierPath *arrow = [UIBezierPath bezierPath];
    [arrow moveToPoint:CGPointMake(self.center.x - 6, 6)];
    [arrow addLineToPoint:CGPointMake(self.center.x, 0)];
    [arrow addLineToPoint:CGPointMake(self.center.x + 6, 6)];
    [arrow closePath];
    arrow.lineWidth = 1;
    [[UIColor whiteColor] setStroke];
    [[UIColor whiteColor] setFill];
    [arrow fill];
    [arrow stroke];
}


@end
