//
//  recent_game.h
//  Max+2x
//
//  Created by dllo on 16/3/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "baseModel.h"

@interface Recent_game : baseModel

@property (nonatomic, copy) NSString *area_id;
@property (nonatomic, copy) NSString *image_url;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *qquin;
@property (nonatomic, retain) NSMutableDictionary *game;

@property (nonatomic, copy) NSString *a;
@property (nonatomic, copy) NSString *champion_img_url;
@property (nonatomic, copy) NSString *champion_name;
@property (nonatomic, copy) NSString *d;
@property (nonatomic, copy) NSString *flag;
@property (nonatomic, copy) NSString *game_id;
@property (nonatomic, copy) NSString *game_type_desc;
@property (nonatomic, copy) NSString *k;
@property (nonatomic, copy) NSString *kda;
@property (nonatomic, copy) NSString *start_time;
@property (nonatomic, copy) NSString *win;
@property (nonatomic, copy) NSString *champion_id;
@property (nonatomic, copy) NSString *map_desc;
@property (nonatomic, copy) NSString *time;


+ (NSMutableArray *)getModelArray:(NSMutableArray *)dataArr;

@end
