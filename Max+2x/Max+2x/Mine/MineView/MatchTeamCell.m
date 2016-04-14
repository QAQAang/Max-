//
//  MatchTeamCell.m
//  Max+2x
//
//  Created by dllo on 16/4/6.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "MatchTeamCell.h"
#import "EquipView.h"
#import <UIImageView+WebCache.h>
@interface MatchTeamCell ()

@property (nonatomic, retain) UIImageView *imageViewHead;

@property (nonatomic, retain) UILabel *textLabelRecord;

@property (nonatomic, retain) EquipView *equipView;

@end

@implementation MatchTeamCell

- (void)setModel:(MatchModel *)model{
    _model = model;
    [self.imageViewHead sd_setImageWithURL:[NSURL URLWithString:model.champion_img_url] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@", model.name]];
    NSRange contentRange = {0,[content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    [content addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:contentRange];
    self.textLabelName.attributedText = content;
    self.textLabelRecord.text = [NSString stringWithFormat:@"%@/%@/%@\n补兵 %@\n总伤害 %.2lf%%", model.k, model.d, model.a, model.minions_killed, [model.total_dmg_percent floatValue]];
    for (int i = 0; i < 6; i++) {
        NSString *imgUrl = [model.items[i] valueForKey:@"image_url"];
        if (![imgUrl  isEqual: @"default"]) {
            [(UIImageView *)self.equipView.imgArr[i] sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"XX.jpg"]];
        }
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatContent];
    }
    return self;
}

- (void)creatContent{
    self.imageViewHead = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageViewHead];
    self.textLabelName = [[UILabel alloc] init];
    self.textLabelName.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.textLabelName];
    self.textLabelRecord = [[UILabel alloc] init];
    self.textLabelRecord.numberOfLines = 3;
    self.textLabelRecord.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:self.textLabelRecord];
    self.equipView = [[EquipView alloc] init];
    [self.contentView addSubview:self.equipView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageViewHead.frame = CGRectMake(10, 5, 50, 50);
    self.textLabelName.frame = CGRectMake(65, 10, 150, 20);
    self.textLabelRecord.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 + 30, 10, 75, 40);
    self.equipView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 70, 9.5, 62, 41);
}

@end
