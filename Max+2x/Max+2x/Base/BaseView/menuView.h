//
//  menuView.h
//  Max_2x_kj
//
//  Created by dllo on 16/3/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "baseView.h"

@protocol MenuViewDelegate <NSObject>

// 代理方法控制VC点击时的页面切换
- (void)clickItemChangeOffset:(NSInteger)count;

@end

@interface menuView : baseView



@property (nonatomic, assign) id<MenuViewDelegate> delegate;

// 改变箭头方法 通过监听调用
- (void)receiveOffset:(CGFloat)contentOffset_x;

// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame menuArr:(NSMutableArray *)array;

@end
