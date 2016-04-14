//
//  SummaryTBcell.m
//  Max+2x
//
//  Created by dllo on 16/3/28.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "SummaryTBcell.h"
#import "SummaryView.h"
@interface SummaryTBcell ()

@property (nonatomic, retain) SummaryView *matchCount;

@property (nonatomic, retain) SummaryView *hideCount;

@property (nonatomic, retain) SummaryView *winningRate;

@property (nonatomic, retain) SummaryView *level;

@end

@implementation SummaryTBcell

- (void)setModel:(GamerPageModel *)model{
    _model = model;
    if (model) {
        self.matchCount.textLabelCount.text = [NSString stringWithFormat:@"%@", model.match_count];
        self.hideCount.textLabelCount.text = [NSString stringWithFormat:@"%@", [model.player_info valueForKey:@"power_value"]];
        self.winningRate.textLabelCount.text = [NSString stringWithFormat:@"%@", [model.win_rate substringWithRange:NSMakeRange(0, 5)]];
        self.level.textLabelCount.text = [NSString stringWithFormat:@"%@", [model.player_info valueForKey:@"level"]];
    }
    self.matchCount.textLabelType.text = @"比赛场数";
    self.hideCount.textLabelType.text = @"隐藏分";
    self.winningRate.textLabelType.text = @"胜率";
    self.level.textLabelType.text = @"等级";
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.matchCount = [[SummaryView alloc] init];
    [self.contentView addSubview:self.matchCount];
    self.hideCount = [[SummaryView alloc] init];
    [self.contentView addSubview:self.hideCount];
    self.winningRate = [[SummaryView alloc] init];
    [self.contentView addSubview:self.winningRate];
    self.level = [[SummaryView alloc] init];
    [self.contentView addSubview:self.level];
    for (int i = 1; i < 4; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width / 4 * i ) - 1, 15, 1, 35)];
        line.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:line];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.matchCount.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 4, 60);
    self.hideCount.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 4, 0, [UIScreen mainScreen].bounds.size.width / 4, 60);
    self.winningRate.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 4 * 2, 0, [UIScreen mainScreen].bounds.size.width / 4, 60);
    self.level.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 4 * 3, 0, [UIScreen mainScreen].bounds.size.width / 4, 60);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
