//
//  mineModel.h
//  Max_2x_kj
//
//  Created by dllo on 16/3/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "baseModel.h"

@interface mineModel : baseModel

@property (nonatomic, retain) NSMutableDictionary *account_detail;
@property (nonatomic, retain) NSMutableDictionary *bind_info;
@property (nonatomic, retain) NSMutableDictionary *group_info;
@property (nonatomic, copy) NSString *notify_time;
@property (nonatomic, retain) NSMutableArray *recent_games;

+ (mineModel *)getModel:(NSMutableDictionary *)dataDic;

@end