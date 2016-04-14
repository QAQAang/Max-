//
//  TeamMateTBCell.m
//  Max+2x
//
//  Created by dllo on 16/4/5.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "TeamMateTBCell.h"
#import <UIImageView+WebCache.h>
@interface TeamMateTBCell ()

@property (nonatomic, retain) UIImageView *imageViewHead;

@property (nonatomic, retain) UILabel *textLabelName;

@property (nonatomic, retain) UIView *winRate;

@property (nonatomic, retain) UILabel *matchCount;

@property (nonatomic, retain) UILabel *textLabelWin_rate_desc;

@end

@implementation TeamMateTBCell

- (void)setModel:(TeamMateModel *)model{
    _model = model;
    [self.imageViewHead sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    self.textLabelName.text = model.name;
    self.textLabelWin_rate_desc.text = [NSString stringWithFormat:@"%.2lf%%", [model.win_rate floatValue]];
    self.winRate.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2, 28, 150 * ([model.win_rate floatValue] / 100), 4);
    self.matchCount.text = [NSString stringWithFormat:@"%@", model.match_count];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.imageViewHead = [[UIImageView alloc] init];
    self.imageViewHead.layer.cornerRadius = 17.5;
    self.imageViewHead.clipsToBounds = YES;
    [self.contentView addSubview:self.imageViewHead];
    self.textLabelName = [[UILabel alloc] init];
    self.textLabelName.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.textLabelName];
    UIView *maxRate = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2, 28, 150, 4)];
    maxRate.backgroundColor = [UIColor colorWithRed:237.f / 255.f green:242.f / 255.f blue:243.f / 255.f alpha:1];
    maxRate.layer.cornerRadius = 2;
    [self.contentView addSubview:maxRate];
    self.winRate = [[UIView alloc] init];
    self.winRate.layer.cornerRadius = 2;
    self.winRate.backgroundColor = [UIColor colorWithRed:75.f / 255.f green:96.f / 255.f blue:113.f / 255.f alpha:1];
    [self.contentView addSubview:self.winRate];
    self.matchCount = [[UILabel alloc] init];
    self.matchCount.textColor = [UIColor grayColor];
    self.matchCount.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.matchCount];
    self.textLabelWin_rate_desc = [[UILabel alloc] init];
    self.textLabelWin_rate_desc.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.textLabelWin_rate_desc];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageViewHead.frame = CGRectMake(10, 2.5, 35, 35);
    self.textLabelName.frame = CGRectMake(55, 0, 100, 40);
    self.matchCount.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 0, 50, 40);
    self.textLabelWin_rate_desc.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2, 10, 50, 15);
}

@end
