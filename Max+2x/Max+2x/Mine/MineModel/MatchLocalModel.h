//
//  MatchLocalModel.h
//  Max+2x
//
//  Created by dllo on 16/4/6.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "baseModel.h"

@interface MatchLocalModel : baseModel

@property (nonatomic, copy) NSString *area_id;
@property (nonatomic, copy) NSString *duration;
@property (nonatomic, copy) NSString *duration_desc;
@property (nonatomic, copy) NSString *finish_time;
@property (nonatomic, copy) NSString *game_id;
@property (nonatomic, copy) NSString *game_mode;
@property (nonatomic, copy) NSString *game_type;
@property (nonatomic, copy) NSString *game_type_desc;
@property (nonatomic, copy) NSString *map;
@property (nonatomic, copy) NSString *map_desc;
@property (nonatomic, copy) NSString *queue;
@property (nonatomic, retain) NSMutableDictionary *server_info;
@property (nonatomic, copy) NSString *start_time_desc;
@property (nonatomic, retain) NSMutableDictionary *sum_team1;
@property (nonatomic, retain) NSMutableDictionary *sum_team2;
@property (nonatomic, retain) NSMutableArray *team1;
@property (nonatomic, retain) NSMutableArray *team2;
@property (nonatomic, copy) NSString *tier;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *win_team;

+ (MatchLocalModel *)getmodel:(NSMutableDictionary *)dataDic;

@end
