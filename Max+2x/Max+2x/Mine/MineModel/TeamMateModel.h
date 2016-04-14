//
//  TeamMateModel.h
//  Max+2x
//
//  Created by dllo on 16/4/6.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "baseModel.h"

@interface TeamMateModel : baseModel

@property (nonatomic, retain) NSString *area_id;
@property (nonatomic, retain) NSString *image_url;
@property (nonatomic, retain) NSString *match_count;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *power_value;
@property (nonatomic, retain) NSString *tier_desc;
@property (nonatomic, retain) NSString *uid;
@property (nonatomic, retain) NSString *win_count;
@property (nonatomic, retain) NSString *win_rate;

+ (NSMutableArray *)getTeamMateModel:(NSMutableArray *)dataArr;

@end
