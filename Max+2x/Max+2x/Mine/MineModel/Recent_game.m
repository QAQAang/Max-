//
//  recent_game.m
//  Max+2x
//
//  Created by dllo on 16/3/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "Recent_game.h"

@implementation Recent_game

+ (NSMutableArray *)getModelArray:(NSMutableArray *)dataArr{
    NSMutableArray *array = [NSMutableArray array];
    for (NSMutableDictionary *dic in dataArr) {
        Recent_game *model = [[Recent_game alloc] initWithDic:dic];
        [model setValuesForKeysWithDictionary:model.game];
        [array addObject:model];
    }
    return array;
}

@end
