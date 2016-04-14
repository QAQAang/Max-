//
//  HearoModel.h
//  Max+2x
//
//  Created by dllo on 16/3/28.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "baseModel.h"

@interface HearoModel : baseModel

@property (nonatomic, retain) NSString *a;
@property (nonatomic, retain) NSString *d;
@property (nonatomic, retain) NSString *image_url;
@property (nonatomic, retain) NSString *k;
@property (nonatomic, retain) NSString *kda;
@property (nonatomic, retain) NSString *kda_count;
@property (nonatomic, retain) NSString *match_count;
@property (nonatomic, retain) NSString *match_count_percent;
@property (nonatomic, retain) NSString *mvp_count;
@property (nonatomic, retain) NSString *mvp_count_percent;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *win_count;
@property (nonatomic, retain) NSString *win_rate_desc;

+ (NSMutableArray *)getHearoModel:(NSMutableArray *)dataArr;

@end
