//
//  DrawCircle.h
//  drawRadar
//
//  Created by dllo on 16/4/7.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawCircle : UIView

@property (nonatomic, retain) UILabel *buttomLabel;

@property (nonatomic, retain) UILabel *centerLabel;

@property (nonatomic, assign) CGFloat rate;

- (instancetype)initWithFrame:(CGRect)frame;

@end
