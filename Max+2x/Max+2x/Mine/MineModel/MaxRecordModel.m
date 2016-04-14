//
//  MaxRecordModel.m
//  Max+2x
//
//  Created by dllo on 16/4/1.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "MaxRecordModel.h"

@implementation MaxRecordModel

+ (NSMutableArray *)getModelArr:(NSMutableArray *)dataArr{
    NSMutableArray *array = [NSMutableArray array];
    for (NSMutableDictionary *dic in dataArr) {
        MaxRecordModel *model = [MaxRecordModel modelWithDic:dic];
        [array addObject:model];
    }
    return array;
}

@end
