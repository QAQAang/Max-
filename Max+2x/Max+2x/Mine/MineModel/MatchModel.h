//
//  MatchModel.h
//  Max+2x
//
//  Created by dllo on 16/4/6.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "baseModel.h"

@interface MatchModel : baseModel

@property (nonatomic, copy) NSString *a;
@property (nonatomic, copy) NSString *champion_id;
@property (nonatomic, copy) NSString *champion_img_url;
@property (nonatomic, copy) NSString *champion_name;
@property (nonatomic, copy) NSString *d;
@property (nonatomic, copy) NSString *dmg_percent;
@property (nonatomic, copy) NSString *exp;
@property (nonatomic, copy) NSString *fight_rate;
@property (nonatomic, copy) NSString *game_score;
@property (nonatomic, copy) NSString *game_score_percent;
@property (nonatomic, copy) NSString *gold_earned;
@property (nonatomic, copy) NSString *gpm;
@property (nonatomic, copy) NSString *hero_detail_params;
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, copy) NSString *k;
@property (nonatomic, copy) NSString *kda;
@property (nonatomic, copy) NSString *largest_killing_spree;
@property (nonatomic, copy) NSString *largest_multi_kill;
@property (nonatomic, copy) NSString *level_desc;
@property (nonatomic, copy) NSString *magic_damage_dealt_to_champions;
@property (nonatomic, copy) NSString *minions_killed;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *physical_damage_dealt_to_champions;
@property (nonatomic, retain) NSMutableDictionary *player_info;
@property (nonatomic, copy) NSString *qquin;
@property (nonatomic, copy) NSString *queue;
@property (nonatomic, retain) NSMutableDictionary *summon_spell1_desc;
@property (nonatomic, retain) NSMutableDictionary *summon_spell2_desc;
@property (nonatomic, retain) NSMutableArray *tag_list;
@property (nonatomic, copy) NSString *team;
@property (nonatomic, copy) NSString *tier;
@property (nonatomic, copy) NSString *tier_desc;
@property (nonatomic, copy) NSString *total_damage_dealt;
@property (nonatomic, copy) NSString *total_damage_dealt_to_champions;
@property (nonatomic, copy) NSString *total_damage_dealt_to_champions_percent;
@property (nonatomic, copy) NSString *total_damage_taken;
@property (nonatomic, copy) NSString *total_dmg_percent;
@property (nonatomic, copy) NSString *total_dmg_taken_percent;
@property (nonatomic, copy) NSString *total_health;
@property (nonatomic, copy) NSString *turrets_killed;
@property (nonatomic, retain) NSMutableDictionary *ward_item;
@property (nonatomic, copy) NSString *ward_killed;
@property (nonatomic, copy) NSString *ward_placed;
@property (nonatomic, copy) NSString *win;
@property (nonatomic, copy) NSString *xpm;


+ (NSMutableArray *)getDataModels:(NSMutableArray *)dataArr;

@end
