//
//  MatchLocalModel.m
//  Max+2x
//
//  Created by dllo on 16/4/6.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "MatchLocalModel.h"
#import "MatchModel.h"
@implementation MatchLocalModel

+ (MatchLocalModel *)getmodel:(NSMutableDictionary *)dataDic{
    MatchLocalModel *model = [MatchLocalModel modelWithDic:dataDic];
    NSMutableArray *array1 = [MatchModel getDataModels:model.team1];
    NSMutableArray *array2 = [MatchModel getDataModels:model.team2];
    model.team1 = array1;
    model.team2 = array2;
    return model;
}

@end
