//
//  SegmentCell.m
//  Max+2x
//
//  Created by dllo on 16/3/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "SegmentCell.h"

@implementation SegmentCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.textLabel = [[UILabel alloc] init];
        self.textLabel.layer.cornerRadius = 10;
        self.textLabel.layer.borderWidth = 0.8;
        self.textLabel.clipsToBounds = YES;
        self.textLabel.alpha = 1;
        self.textLabel.textAlignment = 1;
        self.textLabel.font = [UIFont systemFontOfSize:12];
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.backgroundColor = [UIColor whiteColor];
        self.textLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        [self.contentView addSubview:self.textLabel];
    }
    return self;
}



@end
