//
//  menuCollectionCell.m
//  Max+2x
//
//  Created by dllo on 16/3/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "menuCollectionCell.h"

@implementation menuCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.textLabel = [[UILabel alloc] init];
        self.textLabel.font = [UIFont systemFontOfSize:13];
        self.textLabel.textAlignment = 1;
        self.textLabel.textColor = [UIColor colorWithRed:241.f / 256.f green:242.f / 256.f blue:242.f / 256.f alpha:0.5];
        [self.contentView addSubview:self.textLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 4, 20);
}

@end
