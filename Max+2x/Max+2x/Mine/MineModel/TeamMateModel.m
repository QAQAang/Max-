//
//  TeamMateModel.m
//  Max+2x
//
//  Created by dllo on 16/4/6.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "TeamMateModel.h"

@implementation TeamMateModel

+ (NSMutableArray *)getTeamMateModel:(NSMutableArray *)dataArr{
    NSMutableArray *array = [NSMutableArray array];
    for (NSMutableDictionary *dic in dataArr) {
        TeamMateModel *model = [TeamMateModel modelWithDic:dic];
        [array addObject:model];
    }
    return array;
}

@end
