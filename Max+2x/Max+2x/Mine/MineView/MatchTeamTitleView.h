//
//  MatchTeamTitleView.h
//  Max+2x
//
//  Created by dllo on 16/4/6.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "baseView.h"

@interface MatchTeamTitleView : baseView

@property (nonatomic, retain) UILabel *winLabel;

@property (nonatomic, retain) UILabel *informationLabel;

@property (nonatomic, retain) UIColor *titleColor;

- (instancetype)initWithFrame:(CGRect)frame DrawColor:(UIColor *)drawColor;

@end
