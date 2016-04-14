//
//  baseModel.m
//  Max_2x_kj
//
//  Created by dllo on 16/3/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "baseModel.h"

@implementation baseModel

- (instancetype)initWithDic:(NSMutableDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)modelWithDic:(NSMutableDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _i_d = value;
    }else{
        NSLog(@"%@错误的key是%@", [self class],key);
    }
}


@end
