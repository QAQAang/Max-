//
//  baseModel.h
//  Max_2x_kj
//
//  Created by dllo on 16/3/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface baseModel : NSObject

@property (nonatomic, copy) NSString *i_d;

- (instancetype)initWithDic:(NSMutableDictionary *)dic;

+ (instancetype)modelWithDic:(NSMutableDictionary *)dic;

@end
