//
//  MatchModel.m
//  Max+2x
//
//  Created by dllo on 16/4/6.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "MatchModel.h"

@implementation MatchModel

+ (NSMutableArray *)getDataModels:(NSMutableArray *)dataArr{
    NSMutableArray *array = [NSMutableArray array];
    for (NSMutableDictionary *dic in dataArr) {
        MatchModel *model = [MatchModel modelWithDic:dic];
        [array addObject:model];
    }
    return array;
}

@end
