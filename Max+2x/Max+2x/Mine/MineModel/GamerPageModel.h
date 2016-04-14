//
//  GamerPageModel.h
//  Max+2x
//
//  Created by dllo on 16/3/28.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "baseModel.h"

@interface GamerPageModel : baseModel

@property (nonatomic, copy) NSString *area_id;
@property (nonatomic, copy) NSString *area_name;
@property (nonatomic, copy) NSString *hero_id;
@property (nonatomic, copy) NSString *killing_spree_9;
@property (nonatomic, copy) NSString *lol_update_state;
@property (nonatomic, copy) NSString *match_count;
@property (nonatomic, copy) NSString *max_lose_ser;
@property (nonatomic, copy) NSString *max_win_ser;
@property (nonatomic, copy) NSString *multi_kill_3;
@property (nonatomic, copy) NSString *multi_kill_4;
@property (nonatomic, copy) NSString *multi_kill_5;
@property (nonatomic, copy) NSString *result_streak;
@property (nonatomic, copy) NSString *retry;
@property (nonatomic, copy) NSString *streak_type;
@property (nonatomic, copy) NSString *time_cost;
@property (nonatomic, copy) NSString *win_count;
@property (nonatomic, copy) NSString *win_rate;

@property (nonatomic, retain) NSMutableArray *recent_match_list;
@property (nonatomic, retain) NSMutableArray *game_modes;
@property (nonatomic, retain) NSMutableArray *hero_stat;
@property (nonatomic, retain) NSMutableArray *map_stat;
@property (nonatomic, retain) NSMutableDictionary * player_info;

+ (GamerPageModel *)getGamerModel:(NSMutableDictionary *)dataDic;

@end
