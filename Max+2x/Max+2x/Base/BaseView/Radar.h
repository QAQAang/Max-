//
//  Radar.h
//  drawRadar
//
//  Created by dllo on 16/3/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct {
    CGFloat left;
    CGFloat left_top;
    CGFloat right_top;
    CGFloat right;
    CGFloat right_bottom;
    CGFloat left_bottom;
}Parameter;

CG_INLINE Parameter

ParameterMake(CGFloat left, CGFloat left_top, CGFloat right_top, CGFloat right, CGFloat right_bottom, CGFloat left_bottom)
{
    Parameter parameter;
    parameter.left = left;
    parameter.left_top = left_top;
    parameter.left_bottom = left_bottom;
    parameter.right = right;
    parameter.right_top = right_top;
    parameter.right_bottom = right_bottom;
    return parameter;
}

@interface Radar : UIView

// 参数结构体
@property (nonatomic, assign) Parameter radarParmeter;
// 参数线长度
@property (nonatomic, assign) CGFloat width;
// 六边形层数
@property (nonatomic, assign) NSInteger count;
// 参数最大值
@property (nonatomic, assign) CGFloat maxParmeter;

// 初始化方法
- (instancetype)initWithCenter:(CGPoint)center Parameter:(Parameter)radarParmeter Width:(CGFloat)width FigureCount:(NSInteger)figurecount MaxParmeter:(CGFloat)maxParmeter;

@end
