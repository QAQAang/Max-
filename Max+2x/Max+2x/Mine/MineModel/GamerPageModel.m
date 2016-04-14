//
//  GamerPageModel.m
//  Max+2x
//
//  Created by dllo on 16/3/28.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "GamerPageModel.h"
#import "Recent_game.h"
#import "HearoModel.h"
@implementation GamerPageModel

+ (GamerPageModel *)getGamerModel:(NSMutableDictionary *)dataDic{
    GamerPageModel *model = [GamerPageModel modelWithDic:dataDic];
    NSMutableArray *hearo = [HearoModel getHearoModel:model.hero_stat];
    model.hero_stat = hearo;
    NSMutableArray *recent = [Recent_game getModelArray:model.recent_match_list];
    model.recent_match_list = recent;
    return model;
}

@end
