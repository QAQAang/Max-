//
//  DetailHearoTBCell.m
//  Max+2x
//
//  Created by dllo on 16/4/7.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "DetailHearoTBCell.h"
#import "DrawCircle.h"
#import "DMGRateView.h"
#import "SkillView.h"
#import <UIImageView+WebCache.h>
@interface DetailHearoTBCell ()

@property (nonatomic, retain) DrawCircle *circle;

@property (nonatomic, retain) DMGRateView *rateView;

@property (nonatomic, retain) UILabel *label1;

@property (nonatomic, retain) UILabel *label2;

@property (nonatomic, retain) UILabel *label3;

@property (nonatomic, retain) SkillView *skillView;

@end

@implementation DetailHearoTBCell

- (void)setModel:(MatchModel *)model{
    _model = model;
    self.circle.centerLabel.text = [NSString stringWithFormat:@"%.2lf", [model.game_score floatValue]];
    self.circle.rate = [model.game_score_percent floatValue] / 100;
    [self.circle setNeedsDisplay];
    self.label1.text = [NSString stringWithFormat:@"参战率:%.1lf%%\n最大连杀:%@\n魔法伤害:%@\n物理伤害%@", [model.fight_rate floatValue], model.largest_killing_spree, model.magic_damage_dealt_to_champions, model.physical_damage_dealt_to_champions];
    self.label2.text = [NSString stringWithFormat:@"金钱:%@\n推塔:%@", model.gold_earned, model.turrets_killed];
    self.label3.text = [NSString stringWithFormat:@"插眼数:%@\n承受伤害:%@", model.ward_placed, model.total_damage_taken];
     [(UIImageView *)self.skillView.imgArr[0] sd_setImageWithURL:[NSURL URLWithString:[model.summon_spell1_desc valueForKey:@"image_url"]] placeholderImage:[UIImage imageNamed:@"XX.jpg"]];
    [(UIImageView *)self.skillView.imgArr[1] sd_setImageWithURL:[NSURL URLWithString:[model.summon_spell2_desc valueForKey:@"image_url"]] placeholderImage:[UIImage imageNamed:@"XX.jpg"]];
    [(UIImageView *)self.skillView.imgArr[2] sd_setImageWithURL:[NSURL URLWithString:[model.ward_item valueForKey:@"image_url"]] placeholderImage:[UIImage imageNamed:@"XX.jpg"]];
     NSString *team = [NSString stringWithFormat:@"%@", model.team];
    if ([team isEqualToString:@"100"]) {
        self.rateView.sColor = [UIColor colorWithRed:0 green:190.f / 255.f blue:237.f / 255.f alpha:1];
        self.rateView.eColor = [UIColor colorWithRed:0 green:241.f / 255.f blue:238.f / 255.f alpha:1];
    }else{
        self.rateView.sColor = [UIColor colorWithRed:202 green:79.f / 255.f blue:214.f / 255.f alpha:1];
        self.rateView.eColor = [UIColor colorWithRed:255.f / 255.f green:132.f / 255.f blue:160.f / 255.f alpha:1];
    }
    self.rateView.rate = [model.total_damage_dealt_to_champions_percent floatValue] / 100;
    self.rateView.textLabel.text = [NSString stringWithFormat:@"英雄伤害: %@", model.total_damage_dealt_to_champions];
    self.rateView.frame = CGRectMake(10, 41, [UIScreen mainScreen].bounds.size.width - 142, 17);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.circle = [[DrawCircle alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.circle.backgroundColor = [UIColor clearColor];
    self.circle.buttomLabel.text = @"本局评分";
    [self.contentView addSubview:self.circle];
    self.rateView = [[DMGRateView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.contentView addSubview:self.rateView];
    self.label1 = [[UILabel alloc] init];
    self.label1.font = [UIFont systemFontOfSize:10];
    self.label1.numberOfLines = 4;
    [self.contentView addSubview:self.label1];
    self.label2 = [[UILabel alloc] init];
    self.label2.numberOfLines = 2;
    self.label2.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:self.label2];
    self.label3 = [[UILabel alloc] init];
    self.label3.numberOfLines = 2;
    self.label3.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:self.label3];
    self.skillView = [[SkillView alloc] init];
    [self.contentView addSubview:self.skillView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.label1.frame = CGRectMake(10, 2, ([UIScreen mainScreen].bounds.size.width - 50) / 3, 48);
    self.label2.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 50) / 3 + 10, 2, ([UIScreen mainScreen].bounds.size.width - 50) / 3, 30);
    self.label3.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 50) / 3 * 2 + 10, 2, ([UIScreen mainScreen].bounds.size.width - 50) / 3, 30);
    self.skillView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 142, 35, 62, 20);
    self.rateView.frame = CGRectMake(10, 61, [UIScreen mainScreen].bounds.size.width - 80, 17);
    self.circle.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 65, 20, 50, 50);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
