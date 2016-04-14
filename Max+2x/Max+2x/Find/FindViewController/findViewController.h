//
//  findViewController.h
//  Max_2x_kj
//
//  Created by dllo on 16/3/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "baseViewController.h"

@interface findViewController : baseViewController

@property(nonatomic, assign)NSInteger nextPage; // 记录下一页
@property(nonatomic, assign)BOOL isUpLoading; // 标记上拉操作还是下拉操作,yes为上拉

@end
