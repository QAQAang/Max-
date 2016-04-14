//
//  SegmentView.h
//  Max+2x
//
//  Created by dllo on 16/3/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "baseView.h"

@protocol SegmentViewDelegate <NSObject>

- (void)clickItem:(NSInteger)itemCount;

@end

@interface SegmentView : baseView

@property (nonatomic, assign) id<SegmentViewDelegate> delegate;

@property (nonatomic, retain) NSMutableArray *pickArr;

- (instancetype)initWithItems:(NSMutableArray *)itmeArr;

@end
