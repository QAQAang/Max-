//
//  HearoModel.m
//  Max+2x
//
//  Created by dllo on 16/3/28.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "HearoModel.h"

@implementation HearoModel

+ (NSMutableArray *)getHearoModel:(NSMutableArray *)dataArr{
    NSMutableArray *array = [NSMutableArray array];
    for (NSMutableDictionary *dic in dataArr) {
        HearoModel *model = [HearoModel modelWithDic:dic];
        [array addObject:model];
    }
    return array;
}

@end
