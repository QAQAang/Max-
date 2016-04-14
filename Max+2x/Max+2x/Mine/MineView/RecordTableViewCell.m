//
//  RecordTableViewCell.m
//  Max+2x
//
//  Created by dllo on 16/3/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "RecordTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface RecordTableViewCell ()

@property (nonatomic, retain) UIImageView *imageViewHead;

@property (nonatomic, retain) UILabel *textLabelName;

@property (nonatomic, retain) UILabel *textLabelTime;

@property (nonatomic, retain) UIImageView *imageViewWin;

@property (nonatomic, retain) UILabel *textLabelGame_type_desc;

@property (nonatomic, retain) UILabel *textLabelKDA;

@property (nonatomic, retain) UIImageView *imageViewChampion_img_url;

@end

@implementation RecordTableViewCell

- (void)setModel:(Recent_game *)model{
    _model = model;
    [self.imageViewHead sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    self.textLabelName.text = model.name;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[model.start_time integerValue]];
    NSString *time = [[NSString stringWithFormat:@"%@", confromTimesp] substringWithRange:NSMakeRange(0, 19)];
    self.textLabelTime.text = [RecordTableViewCell compareTime:time];
    if ([model.win isEqual:@1]) {
        self.imageViewWin.image = [UIImage imageNamed:@"iconfont-sheng"];
    }else{
        self.imageViewWin.image = [UIImage imageNamed:@"iconfont-bai"];
    }
    self.textLabelGame_type_desc.text = model.game_type_desc;
    self.textLabelKDA.text = [NSString stringWithFormat:@"%@/%@/%@", model.k, model.d, model.a];
    [self.imageViewChampion_img_url sd_setImageWithURL:[NSURL URLWithString:model.champion_img_url] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifiers{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifiers];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.imageViewHead = [[UIImageView alloc] init];
    self.imageViewHead.layer.cornerRadius = 15;
    self.imageViewHead.clipsToBounds = YES;
    [self.contentView addSubview:self.imageViewHead];
    self.textLabelName = [[UILabel alloc] init];
    self.textLabelName.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.textLabelName];
    self.textLabelTime = [[UILabel alloc] init];
    self.textLabelTime.font = [UIFont systemFontOfSize:13];
    self.textLabelTime.textColor = [UIColor lightGrayColor];
    self.textLabelTime.alpha = 0.8;
    [self.contentView addSubview:self.textLabelTime];
    self.imageViewWin = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageViewWin];
    UIView *line =[[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 + 30, 10, 0.2, 30)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.9;
    [self.contentView addSubview:line];
    self.textLabelGame_type_desc = [[UILabel alloc] init];
    self.textLabelGame_type_desc.textAlignment = NSTextAlignmentRight;
    self.textLabelGame_type_desc.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.textLabelGame_type_desc];
    self.textLabelKDA = [[UILabel alloc] init];
    self.textLabelKDA.font = [UIFont systemFontOfSize:13];
    self.textLabelKDA.textColor = [UIColor lightGrayColor];
    self.textLabelKDA.alpha = 0.8;
    self.textLabelKDA.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.textLabelKDA];
    self.imageViewChampion_img_url = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageViewChampion_img_url];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageViewHead.frame = CGRectMake(10, 10, 30, 30);
    self.textLabelName.frame = CGRectMake(50, 12.5, 100, 12.5);
    self.textLabelTime.frame = CGRectMake(50, 27.5, 100, 10);
    self.imageViewWin.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 + 45, 10, 30, 30);
    self.textLabelGame_type_desc.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 125, 12.5, 75, 12.5);
    self.textLabelKDA.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 125, 27.5, 75, 10);
    self.imageViewChampion_img_url.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 40, 10, 30, 30);
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
