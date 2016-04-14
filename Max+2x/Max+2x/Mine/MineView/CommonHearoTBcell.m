//
//  CommonHearoTBcell.m
//  Max+2x
//
//  Created by dllo on 16/3/28.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "CommonHearoTBcell.h"
#import <UIImageView+WebCache.h>
@interface CommonHearoTBcell ()

@property (nonatomic, retain) UIImageView *imageViewHead;

@property (nonatomic, retain) UILabel *textLabelWin_rate_desc;

@property (nonatomic, retain) UILabel *textLabelMatch_count;

@property (nonatomic, retain) UIView *winningRate;

@property (nonatomic, retain) UILabel *mvpCount;

@property (nonatomic, retain) UILabel *textLabelKDA;

@end

@implementation CommonHearoTBcell

- (void)setModel:(HearoModel *)model{
    _model = model;
    [self.imageViewHead sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    self.textLabelWin_rate_desc.text = [NSString stringWithFormat:@"%@%%", [[NSString stringWithFormat:@"%@", model.win_rate_desc] substringWithRange:NSMakeRange(0, 4)]];
    self.textLabelMatch_count.text = [NSString stringWithFormat:@"%@", model.match_count];
    self.winningRate.frame = CGRectMake(70, 28, 150 * ([model.win_rate_desc floatValue] / 100), 4);
    self.mvpCount.text = [NSString stringWithFormat:@"%@",model.mvp_count];
    NSMutableAttributedString *string;
    NSString *str = [NSString stringWithFormat:@"%.2lf\n%.2lf/%.2lf/%.2lf", [model.kda floatValue], [model.k floatValue], [model.d floatValue], [model.a floatValue]];
    NSRange KDARange = [str rangeOfString:[NSString stringWithFormat:@"%.2lf", [model.kda floatValue]]];
    NSRange subKDARange = [str rangeOfString:[NSString stringWithFormat:@"%.2lf/%.2lf/%.2lf", [model.k floatValue], [model.d floatValue], [model.a floatValue]]];
    string = [[NSMutableAttributedString alloc] initWithString:str];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:KDARange];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:subKDARange];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:subKDARange];
    self.textLabelKDA.attributedText = string;
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
    [self.contentView addSubview:self.imageViewHead];
    self.textLabelWin_rate_desc = [[UILabel alloc] init];
    self.textLabelWin_rate_desc.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.textLabelWin_rate_desc];
    self.textLabelMatch_count = [[UILabel alloc] init];
    self.textLabelMatch_count.font = [UIFont systemFontOfSize:13];
    self.textLabelMatch_count.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.textLabelMatch_count];
    self.mvpCount = [[UILabel alloc] init];
    self.mvpCount.font = [UIFont systemFontOfSize:13];
    self.mvpCount.textAlignment = 1;
    self.mvpCount.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.mvpCount];
    self.textLabelKDA = [[UILabel alloc] init];
    self.textLabelKDA.numberOfLines = 2;
    [self.contentView addSubview:self.textLabelKDA];
    UIView *backGroundLine = [[UIView alloc] initWithFrame:CGRectMake(70, 28, 150, 4)];
    backGroundLine.layer.cornerRadius = 2;
    backGroundLine.backgroundColor = [UIColor colorWithRed:223 / 255.0 green:235 / 255.0 blue:230 / 255.0 alpha:0.8];
    [self.contentView addSubview:backGroundLine];
    self.winningRate = [[UIView alloc] init];
    self.winningRate.layer.cornerRadius = 2;
    self.winningRate.backgroundColor = [UIColor colorWithRed:76 / 255.0 green:146 / 255.0 blue:127 / 255.0 alpha:1];
    [self.contentView addSubview:self.winningRate];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageViewHead.frame = CGRectMake(10, 2.5, 35, 35);
    self.textLabelWin_rate_desc.frame = CGRectMake(70, 10, 50, 15);
    self.textLabelMatch_count.frame = CGRectMake(190, 10, 30, 15);
    self.mvpCount.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 150, 0, 30, 40);
    self.textLabelKDA.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 95, 5, 85, 30);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
