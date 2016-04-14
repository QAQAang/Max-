//
//  MatchViewController.m
//  Max+2x
//
//  Created by dllo on 16/4/6.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "MatchViewController.h"
#import "MatchLocalModel.h"
#import "MatchTeamCell.h"
#import "SummaryView.h"
#import "MatchTeamTitleView.h"
#import "DetailHearoTBCell.h"
@interface MatchViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, retain) UITableView *tableV;

@property (nonatomic, retain) MatchLocalModel *model;

@property (nonatomic, retain) UIView *matchHeadView;

@property (nonatomic, retain) MatchTeamTitleView *blueView;

@property (nonatomic, retain) MatchTeamTitleView *purpleView;

@property (nonatomic, retain) SummaryView *summaryView1;

@property (nonatomic, retain) SummaryView *summaryView2;

@property (nonatomic, retain) SummaryView *summaryView3;

@property (nonatomic, retain) SummaryView *summaryView4;

@property (nonatomic, retain) NSMutableDictionary *swichDic;

@end

@implementation MatchViewController

- (NSMutableDictionary *)swichDic{
    if (_swichDic == nil) {
        _swichDic = [NSMutableDictionary dictionary];
    }
    return _swichDic;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self creatNavGationBar];
    [self creatTableV];
    [self getTaskData];
}

- (void)getTaskData{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.lolmax.com/api/match/detail/?area_id=%@&game_id=%@&pkey=MTQ1ODg3NzY0Mi42MTU5NDE4OTg4ODBfMXV6Z3drb251dW1pcHJtc3M__&phone_num=15941898880&game_type=lol&imei=355021060246177&os_type=Android&os_version=5.0&version=3.2.0", self.areaId, self.gameId]]];
    NSMutableDictionary *dic = [@{@"Referer":@"http://api.maxjia.com/", @"User-Agent":@"Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36 ApiMaxJia/1.0", @"Host":@"api.lolmax.com", @"Connection":@"Keep-Alive", @"Accept-Encoding":@"gzip"} mutableCopy];
    [request setAllHTTPHeaderFields:dic];
    request.HTTPMethod = @"GET";
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self.model = [MatchLocalModel getmodel:[[[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] valueForKey:@"result"] valueForKey:@"match_info"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.summaryView1.textLabelCount.text = @"结束时间";
            NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[self.model.finish_time integerValue]];
            NSString *time = [[NSString stringWithFormat:@"%@", confromTimesp] substringWithRange:NSMakeRange(0, 19)];
            self.summaryView1.textLabelType.text = [MatchViewController compareTime:time];
            self.summaryView2.textLabelCount.text = @"持续时间";
            self.summaryView2.textLabelType.text = [NSString stringWithFormat:@"%@", self.model.duration_desc];
            self.summaryView3.textLabelCount.text = @"地图";
            self.summaryView3.textLabelType.text = self.model.map_desc;
            self.summaryView4.textLabelCount.text = @"比赛模式";
            self.summaryView4.textLabelType.text = self.model.game_type_desc;
            if ([self.model.win_team isEqual:@1]) {
                self.blueView.winLabel.text = @"蓝队 : 胜利";
                self.purpleView.winLabel.text = @"紫队 : 失败";
            }else{
                self.blueView.winLabel.text = @"蓝队 : 失败";
                self.purpleView.winLabel.text = @"紫队 : 胜利";
            }
            self.blueView.informationLabel.text = [NSString stringWithFormat:@"杀敌%@  经验%@  金钱%@", [self.model.sum_team1 valueForKey:@"sum_k"], [self.model.sum_team1 valueForKey:@"sum_exp"], [self.model.sum_team1 valueForKey:@"sum_gold_earned"]];
            self.purpleView.informationLabel.text = [NSString stringWithFormat:@"杀敌%@  经验%@  金钱%@", [self.model.sum_team1 valueForKey:@"sum_k"], [self.model.sum_team1 valueForKey:@"sum_exp"], [self.model.sum_team1 valueForKey:@"sum_gold_earned"]];
            for (int i =  0; i < 2; i++) {
                for (int k = 0; k < self.model.team1.count * 2; k++) {
                    if (k % 2 == 0) {
                        [self.swichDic setObject:@0 forKey:[NSString stringWithFormat:@"%d%d", i, k]];
                    }
                }
            }
            [self.tableV reloadData];
        });
    }] resume];
}

- (void)creatTableV{
    self.tableV = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.bounces = NO;
    [self.tableV registerClass:[MatchTeamCell class] forCellReuseIdentifier:@"match"];
    [self.tableV registerClass:[DetailHearoTBCell class] forCellReuseIdentifier:@"detail"];
    [self.view addSubview:self.tableV];
    self.matchHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    [self creatSummary];
    self.matchHeadView.backgroundColor = [UIColor colorWithRed:56 / 255.0 green:65 / 255.0 blue:73 / 255.0 alpha:1.000];
    self.tableV.tableHeaderView = self.matchHeadView;
}

- (void)creatSummary{
    self.summaryView1 = [[SummaryView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 4, 30)];
    self.summaryView1.textLabelCount.frame = CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width / 4, 15);
    self.summaryView1.textLabelCount.font = [UIFont systemFontOfSize:12];
    self.summaryView1.textLabelCount.textColor = [UIColor colorWithRed:241.f / 256.f green:242.f / 256.f blue:242.f / 256.f alpha:0.5];
    self.summaryView1.textLabelType.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width / 4, 15);
    self.summaryView1.textLabelType.font = [UIFont systemFontOfSize:13];
    self.summaryView1.textLabelType.textColor = [UIColor whiteColor];
    [self.matchHeadView addSubview:self.summaryView1];
    
    self.summaryView2 = [[SummaryView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 4, 0, [UIScreen mainScreen].bounds.size.width / 4, 30)];
    self.summaryView2.textLabelCount.frame = CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width / 4, 15);
    self.summaryView2.textLabelCount.font = [UIFont systemFontOfSize:12];
    self.summaryView2.textLabelCount.textColor = [UIColor colorWithRed:241.f / 256.f green:242.f / 256.f blue:242.f / 256.f alpha:0.5];
    self.summaryView2.textLabelType.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width / 4, 15);
    self.summaryView2.textLabelType.font = [UIFont systemFontOfSize:13];
    self.summaryView2.textLabelType.textColor = [UIColor whiteColor];
    [self.matchHeadView addSubview:self.summaryView2];
    
    self.summaryView3 = [[SummaryView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2, 0, [UIScreen mainScreen].bounds.size.width / 4, 30)];
    self.summaryView3.textLabelCount.frame = CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width / 4, 15);
    self.summaryView3.textLabelCount.font = [UIFont systemFontOfSize:12];
    self.summaryView3.textLabelCount.textColor = [UIColor colorWithRed:241.f / 256.f green:242.f / 256.f blue:242.f / 256.f alpha:0.5];
    self.summaryView3.textLabelType.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width / 4, 15);
    self.summaryView3.textLabelType.font = [UIFont systemFontOfSize:13];
    self.summaryView3.textLabelType.textColor = [UIColor whiteColor];
    [self.matchHeadView addSubview:self.summaryView3];
    
    self.summaryView4 = [[SummaryView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 4 * 3, 0, [UIScreen mainScreen].bounds.size.width / 4, 30)];
    self.summaryView4.textLabelCount.frame = CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width / 4, 15);
    self.summaryView4.textLabelCount.font = [UIFont systemFontOfSize:12];
    self.summaryView4.textLabelCount.textColor = [UIColor colorWithRed:241.f / 256.f green:242.f / 256.f blue:242.f / 256.f alpha:0.5];
    self.summaryView4.textLabelType.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width / 4, 15);
    self.summaryView4.textLabelType.font = [UIFont systemFontOfSize:13];
    self.summaryView4.textLabelType.textColor = [UIColor whiteColor];
    [self.matchHeadView addSubview:self.summaryView4];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.model.team1.count * 2;
    }else{
        return self.model.team2.count * 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MatchTeamCell *cell = [tableView dequeueReusableCellWithIdentifier:@"match"];
    DetailHearoTBCell *detail = [tableView dequeueReusableCellWithIdentifier:@"detail"];
    detail.selectionStyle = UITableViewCellAccessoryNone;
    if (indexPath.section == 0) {
        if (indexPath.row % 2 == 0) {
            cell.model = self.model.team1[indexPath.row / 2];
            cell.textLabelName.textColor = [UIColor colorWithRed:7.f / 255.f green:124.f / 255.f blue:209.f / 255.f alpha:1];
            return cell;
        }else{
            if ([[self.swichDic objectForKey:[NSString stringWithFormat:@"%ld%ld", indexPath.section, indexPath.row - 1]] isEqualToNumber:@0]){
                detail.hidden = YES;
            }else{
                detail.hidden = NO;
            }
            detail.model = self.model.team1[(indexPath.row - 1) / 2];
            return detail;
        }
    }else{
        if (indexPath.row % 2 == 0) {
            cell.model = self.model.team2[indexPath.row / 2];
            cell.textLabelName.textColor = [UIColor purpleColor];
            return cell;
        }else{
            if ([[self.swichDic objectForKey:[NSString stringWithFormat:@"%ld%ld", indexPath.section, indexPath.row - 1]] isEqualToNumber:@0]){
                detail.hidden = YES;
            }else{
                detail.hidden = NO;
            }
            detail.model = self.model.team1[(indexPath.row - 1) / 2];
            return detail;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row % 2 == 0) {
        return 60;
    }else{
        NSLog(@"%@", self.swichDic);
        NSLog(@"%@", [NSString stringWithFormat:@"%ld%ld", indexPath.section, indexPath.row]);
        if ([[self.swichDic objectForKey:[NSString stringWithFormat:@"%ld%ld", indexPath.section, indexPath.row - 1]] isEqual:@0]) {
            return 0;
        }else{
            return 80;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        self.blueView = [[MatchTeamTitleView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40) DrawColor:[UIColor colorWithRed:7.f / 255.f green:124.f / 255.f blue:209.f / 255.f alpha:1]];
        if ([self.model.win_team isEqual:@1]) {
            self.blueView.winLabel.text = @"蓝队 : 胜利";
        }else{
            self.blueView.winLabel.text = @"蓝队 : 失败";
        }
        self.blueView.informationLabel.text = [NSString stringWithFormat:@"杀敌%@  经验%@  金钱%@", [self.model.sum_team1 valueForKey:@"sum_k"], [self.model.sum_team1 valueForKey:@"sum_exp"], [self.model.sum_team1 valueForKey:@"sum_gold_earned"]];
        return self.blueView;
    }else{
        self.purpleView = [[MatchTeamTitleView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40) DrawColor:[UIColor colorWithRed:161.f / 255.f green:64.f / 255.f blue:173.f / 255.f alpha:1]];
        if ([self.model.win_team isEqual:@1]) {
            self.purpleView.winLabel.text = @"紫队 : 失败";
        }else{
            self.purpleView.winLabel.text = @"紫队 : 胜利";
        }
        self.purpleView.informationLabel.text = [NSString stringWithFormat:@"杀敌%@  经验%@  金钱%@", [self.model.sum_team1 valueForKey:@"sum_k"], [self.model.sum_team1 valueForKey:@"sum_exp"], [self.model.sum_team1 valueForKey:@"sum_gold_earned"]];
        return self.purpleView;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[self tableView:tableView cellForRowAtIndexPath:indexPath] isKindOfClass:[MatchTeamCell class]]) {
        if ([[self.swichDic objectForKey:[NSString stringWithFormat:@"%ld%ld", indexPath.section, indexPath.row]] isEqualToNumber:@0]) {
            [self.swichDic setObject:@1 forKey:[NSString stringWithFormat:@"%ld%ld", indexPath.section, indexPath.row]];
            [self tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section]].hidden = NO;
            [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section]]withRowAnimation:UITableViewRowAnimationBottom];
            
        }else{
            [self.swichDic setObject:@0 forKey:[NSString stringWithFormat:@"%ld%ld", indexPath.section, indexPath.row]];
             [self tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section]].hidden = YES;
            [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section]]withRowAnimation:UITableViewRowAnimationTop];
           
        }
    }
}

- (void)creatNavGationBar{
    UIImage *orImage = [UIImage imageNamed:@"iconfont-jzuojiantou"];
    orImage = [self imageWithImageSimple:orImage scaledToSize:CGSizeMake(30, 30)];
    [orImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton *buton = [UIButton buttonWithType:UIButtonTypeCustom];
    buton.frame = CGRectMake(0, 0, 50, 50);
    [buton setImage:orImage forState:UIControlStateNormal];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithImage:orImage style:UIBarButtonItemStylePlain target:self action:@selector(clickBack)];
    leftBar.tintColor = [UIColor colorWithRed:235 green:240 blue:241 alpha:1];
    self.navigationItem.leftBarButtonItem = leftBar;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 3, 20)];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.text = [NSString stringWithFormat:@"比赛%@", self.gameId];
    self.navigationItem.titleView = label;
    
}

- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

- (void)clickBack{
    [self.navigationController popViewControllerAnimated:YES];
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
