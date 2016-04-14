//
//  LatelyMatchTBcell.m
//  Max+2x
//
//  Created by dllo on 16/3/28.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LatelyMatchTBcell.h"
#import <UIImageView+WebCache.h>
@interface LatelyMatchTBcell ()

@property (nonatomic, retain) UIImageView *imageViewHearo;

@property (nonatomic, retain) UIImageView *imageViewWin;

@property (nonatomic, retain) UILabel *textLabelGameType;

@property (nonatomic, retain) UILabel *textLabelEndTime;

@property (nonatomic, retain) UILabel *textLabelKDA;

@end

@implementation LatelyMatchTBcell

- (void)setModel:(Recent_game *)model{
    _model = model;
    [self.imageViewHearo sd_setImageWithURL:[NSURL URLWithString:model.champion_img_url] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    if ([model.win isEqual:@1]) {
        self.imageViewWin.image = [UIImage imageNamed:@"iconfont-sheng"];
    }else{
        self.imageViewWin.image = [UIImage imageNamed:@"iconfont-bai"];
    }
    self.textLabelGameType.text = model.game_type_desc;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[model.time integerValue]];
    NSString *time = [[NSString stringWithFormat:@"%@", confromTimesp] substringWithRange:NSMakeRange(0, 19)];
    self.textLabelEndTime.text = [LatelyMatchTBcell compareTime:time];
    NSString *str = [NSString stringWithFormat:@"%.2lf\n%ld/%ld/%ld", [model.kda floatValue], [model.k integerValue], [model.d integerValue], [model.a integerValue]];
    NSRange KDARange = [str rangeOfString:[NSString stringWithFormat:@"%.2lf", [model.kda floatValue]]];
    NSRange subKDARange = [str rangeOfString:[NSString stringWithFormat:@"%ld/%ld/%ld", [model.k integerValue], [model.d integerValue], [model.a integerValue]]];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:KDARange];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:subKDARange];
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
    self.imageViewHearo = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageViewHearo];
    self.imageViewWin = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageViewWin];
    self.textLabelGameType = [[UILabel alloc] init];
    self.textLabelGameType.textAlignment = 1;
    self.textLabelGameType.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.textLabelGameType];
    self.textLabelEndTime = [[UILabel alloc] init];
    self.textLabelEndTime.textAlignment = 1;
    self.textLabelEndTime.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.textLabelEndTime];
    self.textLabelKDA = [[UILabel alloc] init];
    self.textLabelKDA.numberOfLines = 2;
    [self.contentView addSubview:self.textLabelKDA];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageViewHearo.frame = CGRectMake(10, 2.5, 35, 35);
    self.imageViewWin.frame = CGRectMake(70, 5, 30, 30);
    self.textLabelGameType.frame = CGRectMake(110, 10, 75, 20);
    self.textLabelEndTime.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 175, 10, 75, 20);
    self.textLabelKDA.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 75, 0, 50, 40);
}

+ (NSString *)compareTime:(NSString *)creatTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentTime = [dateFormatter stringFromDate:date];
    NSInteger currentDay = [[currentTime substringWithRange:NSMakeRange(8, 2)] integerValue];
    NSInteger creatDay = [[creatTime substringWithRange:NSMakeRange(8, 2)] integerValue];
    NSInteger currentHour = [[currentTime substringWithRange:NSMakeRange(11, 2)] integerValue];
    NSInteger creatHour = [[creatTime substringWithRange:NSMakeRange(11, 2)] integerValue];
    NSInteger currentMonth = [[currentTime substringWithRange:NSMakeRange(5, 2)] integerValue];
    NSInteger creatMonth = [[creatTime substringWithRange:NSMakeRange(5, 2)] integerValue];
    NSInteger currentYear = [[currentTime substringWithRange:NSMakeRange(0, 4)] integerValue];
    NSInteger creatYear =  [[creatTime substringWithRange:NSMakeRange(0, 4)] integerValue];
    if (currentYear == creatYear) {
        if (currentMonth == creatMonth) {
            if (currentDay == creatDay) {
                if (creatHour != currentHour) {
                    return [NSString stringWithFormat:@"%ld小时前", currentHour - creatHour];
                }else{
                    return @"1小时以内";
                }
            }else{
                if (currentDay - creatDay == 1) {
                    if (creatHour - currentHour + 12 < 24) {
                        return [NSString stringWithFormat:@"%ld小时前", currentHour - creatHour + 15];
                    }else{
                        return @"昨天";
                    }
                }else if (currentDay - creatDay == 2){
                    return @"前天";
                }else{
                    return [NSString stringWithFormat:@"%ld天前", currentDay - creatDay];
                }
            }
        }else{
            if (currentMonth - creatMonth == 1) {
                if (currentDay + 30 - creatDay >= 30) {
                    return [NSString stringWithFormat:@"%ld个月前", currentMonth - creatMonth];
                }else{
                    return [NSString stringWithFormat:@"%ld天前", currentDay + 30 - creatDay];
                }
            }else{
                return [NSString stringWithFormat:@"%ld个月前", currentMonth - creatMonth];
            }
        }
    }else{
        if (currentYear - creatYear == 1) {
            if (currentMonth + 12 - creatMonth >= 12) {
                return [NSString stringWithFormat:@"%ld年前", currentYear - creatYear];
            }else{
                return [NSString stringWithFormat:@"%ld个月前", currentMonth + 11 - creatMonth];
            }
        }else{
            return [NSString stringWithFormat:@"%ld年前", currentYear - creatYear];
        }
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
