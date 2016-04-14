//
//  RoleTableViewCell.m
//  Max+2x
//
//  Created by dllo on 16/3/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "RoleTableViewCell.h"

@implementation RoleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageViewHead = [[UIImageView alloc] init];
        self.imageViewHead.layer.cornerRadius = 15;
        self.imageViewHead.clipsToBounds = YES;
        [self.contentView addSubview:self.imageViewHead];
        self.textLabelName = [[UILabel alloc] init];
        self.textLabelName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.textLabelName];
        self.skipView = [[SkipView alloc] init];
        [self.contentView addSubview:self.skipView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageViewHead.frame = CGRectMake(10, 10, 30, 30);
    self.textLabelName.frame = CGRectMake(50, 15, 150, 20);
    self.skipView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 100, 15, 90, 20);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
