//
//  MaxRecordTBCell.m
//  Max+2x
//
//  Created by dllo on 16/4/1.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "MaxRecordTBCell.h"
#import <UIImageView+WebCache.h>
@interface MaxRecordTBCell ()

@property (nonatomic, retain) UIImageView *imageViewHead;

@property (nonatomic, retain) UILabel *textLabelRecord;

@property (nonatomic, retain) UILabel *textLabelData;

@property (nonatomic, retain) UILabel *textLabelTime;

@property (nonatomic, retain) UIImageView *imageViewResult;

@end

@implementation MaxRecordTBCell

- (void)setModel:(MaxRecordModel *)model{
    _model = model;
    [self.imageViewHead sd_setImageWithURL:[NSURL URLWithString:model.champion_img_url] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    self.textLabelRecord.text = model.tag;
    self.textLabelData.text = [NSString stringWithFormat:@"%@", model.value];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[model.time integerValue]];
    NSString *time = [[NSString stringWithFormat:@"%@", confromTimesp] substringWithRange:NSMakeRange(0, 19)];
    self.textLabelTime.text = [MaxRecordTBCell compareTime:time];
    if ([model.win isEqual:@1]) {
        self.imageViewResult.image = [UIImage imageNamed:@"iconfont-sheng"];
    }else{
        self.imageViewResult.image = [UIImage imageNamed:@"iconfont-bai"];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatCell];
    }
    return self;
}

- (void)creatCell{
    self.imageViewHead = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageViewHead];
    self.textLabelRecord = [[UILabel alloc] init];
    self.textLabelRecord.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.textLabelRecord];
    self.textLabelData = [[UILabel alloc] init];
    self.textLabelData.font = [UIFont systemFontOfSize:13];
    self.textLabelData.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.textLabelData];
    self.textLabelTime = [[UILabel alloc] init];
    self.textLabelTime.font = [UIFont systemFontOfSize:12];
    self.textLabelTime.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.textLabelTime];
    self.imageViewResult = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageViewResult];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageViewHead.frame = CGRectMake(10, 2.5, 35, 35);
    self.textLabelRecord.frame = CGRectMake(55, 0, 100, 40);
    self.textLabelData.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 200, 0, 60, 40);
    self.textLabelTime.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 130, 0, 75, 40);
    self.imageViewResult.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 40, 5, 30, 30);
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

@end
