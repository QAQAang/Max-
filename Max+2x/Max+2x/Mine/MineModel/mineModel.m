//
//  mineModel.m
//  Max_2x_kj
//
//  Created by dllo on 16/3/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "mineModel.h"
#import "Recent_game.h"
@implementation mineModel

+ (mineModel *)getModel:(NSMutableDictionary *)dataDic{
    mineModel *model = [mineModel modelWithDic:dataDic];
    NSMutableArray *array = [Recent_game getModelArray:model.recent_games];
    model.recent_games = array;
    return model;
}

@end
