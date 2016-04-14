//
//  findModel.m
//  Max_2x_kj
//
//  Created by dllo on 16/3/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "findModel.h"

@implementation findModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"newUrl"]) {
        self.webUrl = [NSString stringWithFormat:@"%@", value];
    }
    
    
}

-(id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

@end
