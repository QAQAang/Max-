//
//  EquipView.m
//  Max+2x
//
//  Created by dllo on 16/4/6.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "EquipView.h"

@interface EquipView ()

@property (nonatomic, retain) UIImageView *imageV1;
@property (nonatomic, retain) UIImageView *imageV2;
@property (nonatomic, retain) UIImageView *imageV3;
@property (nonatomic, retain) UIImageView *imageV4;
@property (nonatomic, retain) UIImageView *imageV5;
@property (nonatomic, retain) UIImageView *imageV6;

@end

@implementation EquipView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatImage];
    }
    return self;
}

- (void)creatImage{
    self.imgArr = [NSMutableArray array];
    self.imageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.imageV1.image = [UIImage imageNamed:@"XX.jpg"];
    [self addSubview:self.imageV1];
    self.imageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(21, 0, 20, 20)];
    self.imageV2.image = [UIImage imageNamed:@"XX.jpg"];
    [self addSubview:self.imageV2];
    self.imageV3 = [[UIImageView alloc] initWithFrame:CGRectMake(42, 0, 20, 20)];
    self.imageV3.image = [UIImage imageNamed:@"XX.jpg"];
    [self addSubview:self.imageV3];
    self.imageV4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 21, 20, 20)];
    self.imageV4.image = [UIImage imageNamed:@"XX.jpg"];
    [self addSubview:self.imageV4];
    self.imageV5 = [[UIImageView alloc] initWithFrame:CGRectMake(21, 21, 20, 20)];
    self.imageV5.image = [UIImage imageNamed:@"XX.jpg"];
    [self addSubview:self.imageV5];
    self.imageV6 = [[UIImageView alloc] initWithFrame:CGRectMake(42, 21, 20, 20)];
    self.imageV6.image = [UIImage imageNamed:@"XX.jpg"];
    [self addSubview:self.imageV6];
    [self.imgArr addObject:self.imageV1];
    [self.imgArr addObject:self.imageV2];
    [self.imgArr addObject:self.imageV3];
    [self.imgArr addObject:self.imageV4];
    [self.imgArr addObject:self.imageV5];
    [self.imgArr addObject:self.imageV6];
}

@end
