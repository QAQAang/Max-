//
//  findModel.h
//  Max_2x_kj
//
//  Created by dllo on 16/3/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "baseModel.h"

@interface findModel : baseModel

@property(nonatomic, copy)NSString *webUrl;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *date;
@property(nonatomic, assign)NSInteger click;
@property(nonatomic, retain)NSMutableArray *imgs;
@property(nonatomic, copy)NSString *url;

@end
