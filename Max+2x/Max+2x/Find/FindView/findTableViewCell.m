//
//  findTableViewCell.m
//  Max+2x
//
//  Created by 谷萌雨 on 16/3/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height


#import "findTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface findTableViewCell ()

@property(nonatomic, retain)UILabel *titleLabel;
@property(nonatomic, retain)UILabel *timeLabel;
@property(nonatomic, retain)UIImageView *titleImageView;
@property(nonatomic, retain)UILabel *countLabel;

@end

@implementation findTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
        [self creatSubViews];
        
        
    }
    
    return self;
    
}


-(void)creatSubViews{
    
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.314 * SCREENW + 10, 10, 0.63 * SCREENW, 45)];
    //    self.titleLabel.backgroundColor = [UIColor orangeColor];
    self.titleLabel.text = @"测试标题测试标题测试标题";
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.titleLabel];
    
    self.titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"aaa"]];
    
    self.titleImageView.frame = CGRectMake(0, 0, 0.314 * SCREENW, 93);
    [self.contentView addSubview:self.titleImageView];
    
    UILabel *labelLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 93, SCREENW, 7)];
    labelLine.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [self.contentView addSubview:labelLine];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.314 * SCREENW + 10, 100 - 40, 0.425 * SCREENW, 20)];
    self.timeLabel.text = @"2016-01-01 10:00:00";
    self.timeLabel.textColor = [UIColor lightGrayColor];
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    //    self.timeLabel.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:self.timeLabel];
    
    self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENW - 0.193 * SCREENW, 100 - 40, 0.193 * SCREENW, 20)];
    self.countLabel.text = @"10000";
    self.countLabel.textColor = [UIColor lightGrayColor];
    self.countLabel.font = [UIFont systemFontOfSize:13];
    //    self.countLabel.backgroundColor = [UIColor purpleColor];
    [self.contentView addSubview:self.countLabel];
    
    
}

- (void)setFindM:(findModel *)findM{
    
    _findM = findM;
    
    self.titleLabel.text = findM.title;
    self.countLabel.text = [NSString stringWithFormat:@"人数 %ld", findM.click];
    self.timeLabel.text = findM.date;
    
    NSString *urlPic = findM.imgs[0];
    NSLog(@"urlPic = %@", urlPic);
    
    // 异步加载图片
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:urlPic]];
    
    
}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
