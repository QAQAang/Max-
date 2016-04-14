//
//  MaxRecordVC.m
//  Max+2x
//
//  Created by dllo on 16/4/1.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "MaxRecordVC.h"
#import "MaxRecordModel.h"
#import "MaxRecordTBCell.h"
#import "TitleCell.h"
#import "SummaryView.h"
@interface MaxRecordVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableV;

@property (nonatomic, retain) NSMutableDictionary *modelDic;

@property (nonatomic, retain) NSMutableArray *modelArr;

@property (nonatomic, retain) SummaryView *maxWincount;

@property (nonatomic, retain) SummaryView *maxLosecount;

@end

@implementation MaxRecordVC

- (NSMutableArray *)modelArr{
    if (_modelArr == nil) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
}

- (NSMutableDictionary *)modelDic{
    if (_modelDic == nil) {
        _modelDic = [NSMutableDictionary dictionary];
    }
    return _modelDic;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 162);
    [self creatTableV];
    [self getTaskData];
    [self creatHeadTitle];
}

- (void)creatHeadTitle{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    view.backgroundColor = [UIColor whiteColor];
    self.maxWincount = [[SummaryView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 2, 60)];
    self.maxWincount.textLabelCount.textColor = [UIColor colorWithRed:0 green:136.f / 255.f blue:56.f / 255.f alpha:1];
    self.maxWincount.textLabelCount.frame = CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width  / 2, 25);
    self.maxWincount.textLabelType.textColor = [UIColor blackColor];
    self.maxWincount.textLabelType.text = @"最高连胜";
    self.maxWincount.textLabelType.frame = CGRectMake(0, 25, [UIScreen mainScreen].bounds.size.width / 2, 35);
    [view addSubview:self.maxWincount];
    self.maxLosecount = [[SummaryView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 , 0, [UIScreen mainScreen].bounds.size.width / 2, 60)];
    self.maxLosecount.textLabelCount.textColor = [UIColor colorWithRed:159.f / 255.f green:38.f / 255.f blue:47.f / 255.f alpha:1];
    self.maxLosecount.textLabelCount.frame = CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width  / 2, 25);
    self.maxLosecount.textLabelType.textColor = [UIColor blackColor];
    self.maxLosecount.textLabelType.text = @"最高连败";
    self.maxLosecount.textLabelType.frame = CGRectMake(0, 25, [UIScreen mainScreen].bounds.size.width / 2, 35);
    [view addSubview:self.maxLosecount];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 0.5, 10, 0.5, 40)];
    line.backgroundColor = [UIColor blackColor];
    [view addSubview:line];
    self.tableV.tableHeaderView = view;
}

- (void)getTaskData{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.lolmax.com/api/player/peak_list/?area_id=%@&uid=%@&pkey=MTQ1ODg3NzY0Mi42MTU5NDE4OTg4ODBfMXV6Z3drb251dW1pcHJtc3M__&phone_num=15941898880&game_type=lol&imei=355021060246177&os_type=Android&os_version=5.0&version=3.2.0", self.areaId, [self.name stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLQueryAllowedCharacterSet]]]]];
    NSMutableDictionary *dic = [@{@"Referer":@"http://api.maxjia.com/", @"User-Agent":@"Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36 ApiMaxJia/1.0", @"Host":@"api.lolmax.com", @"Connection":@"Keep-Alive", @"Accept-Encoding":@"gzip"} mutableCopy];
    [request setAllHTTPHeaderFields:dic];
    request.HTTPMethod = @"GET";
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self.modelDic = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] valueForKey:@"result"];
        self.modelArr = [MaxRecordModel getModelArr:[self.modelDic objectForKey:@"peak_list"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableV reloadData];
            self.maxWincount.textLabelCount.text = [NSString stringWithFormat:@"%@", [self.modelDic valueForKey:@"max_win_ser"]];
            self.maxLosecount.textLabelCount.text = [NSString stringWithFormat:@"%@", [self.modelDic valueForKey:@"max_lose_ser"]];
        });
    }] resume];
}

- (void)creatTableV{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 162) style:1];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.tableV registerClass:[MaxRecordTBCell class] forCellReuseIdentifier:@"cell"];
    [self.tableV registerClass:[TitleCell class] forCellReuseIdentifier:@"title"];
    [self.view addSubview:self.tableV];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MaxRecordTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellAccessoryNone;
    if (indexPath.row == 0) {
        TitleCell *title = [tableView dequeueReusableCellWithIdentifier:@"title"];
        title.selectionStyle = UITableViewCellAccessoryNone;
        if (title.subviews.count == 1) {
            [title.titleView addSubview:[self creatTitle]];
        }
        return title;
    }else{
        cell.model = self.modelArr[indexPath.row - 1];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 20;
    }else{
        return 40;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 5, 20)];
    line.backgroundColor = [UIColor colorWithRed:45 / 255.0 green:56 / 255.0 blue:65 / 255.0 alpha:1.000];
    [head addSubview:line];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 20)];
    label.text = @"记录";
    label.font = [UIFont systemFontOfSize:13];
    [head addSubview:label];
    return head;
}

- (UIView *)creatTitle{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 35, 20)];
    label1.text = @"英雄";
    label1.textAlignment = 1;
    label1.font = [UIFont systemFontOfSize:12];
    label1.textColor = [UIColor lightGrayColor];
    [view addSubview:label1];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, 35, 20)];
    label2.text = @"记录";
    label2.font = [UIFont systemFontOfSize:12];
    label2.textColor = [UIColor lightGrayColor];
    [view addSubview:label2];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 200, 0, 60, 20)];
    label3.textAlignment = NSTextAlignmentRight;
    label3.font = [UIFont systemFontOfSize:12];
    label3.text = @"数据";
    label3.textColor = [UIColor lightGrayColor];
    [view addSubview:label3];
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 130, 0, 75, 20)];
    label4.text = @"时间";
    label4.textAlignment = NSTextAlignmentRight;
    label4.textColor = [UIColor lightGrayColor];
    label4.font = [UIFont systemFontOfSize:12];
    [view addSubview:label4];
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 40, 0, 30, 20)];
    label5.text = @"结果";
    label5.font = [UIFont systemFontOfSize:12];
    label5.textColor = [UIColor lightGrayColor];
    [view addSubview:label5];
    return view;
}

@end
