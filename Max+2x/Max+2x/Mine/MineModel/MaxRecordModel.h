//
//  MaxRecordModel.h
//  Max+2x
//
//  Created by dllo on 16/4/1.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "baseModel.h"

@interface MaxRecordModel : baseModel

@property (nonatomic, copy) NSString *area_id;
@property (nonatomic, copy) NSString *champion_id;
@property (nonatomic, copy) NSString *champion_img_url;
@property (nonatomic, copy) NSString *champion_name;
@property (nonatomic, copy) NSString *game_id;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *win;

+ (NSMutableArray *)getModelArr:(NSMutableArray *)dataArr;

@end
