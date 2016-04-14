//
//  StatisticsVC.m
//  Max+2x
//
//  Created by dllo on 16/3/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "StatisticsVC.h"
#import "GamerPageModel.h"
#import "SummaryTBcell.h"
#import "LatelyMatchTBcell.h"
#import "CommonHearoTBcell.h"
#import "SegmentView.h"
#import "TitleCell.h"
@interface StatisticsVC ()<UITableViewDataSource, UITableViewDelegate, SegmentViewDelegate>

@property (nonatomic, retain) GamerPageModel *model;

@property (nonatomic, retain) UITableView *tableV;

@property (nonatomic, retain) NSMutableArray *pickArr;

@property (nonatomic, retain) SegmentView *segmentView;

@end

@implementation StatisticsVC

- (NSMutableArray *)pickArr{
    if (_pickArr == nil) {
        _pickArr = [NSMutableArray arrayWithObjects:@1, @0, @0, @0, nil];
    }
    return _pickArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 162);
    [self creatTableV];
    [self getTaskData];
}

- (void)getTaskData{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.lolmax.com/api/player/summary/?area_id=%@&uid=%@&pull=1&mode=all&pkey=MTQ1ODg3NzY0Mi42MTU5NDE4OTg4ODBfMXV6Z3drb251dW1pcHJtc3M__&phone_num=15941898880&game_type=lol&imei=355021060246177&os_type=Android&os_version=5.0&version=3.2.0", self.areaId, [self.name stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLQueryAllowedCharacterSet]]]]];
    NSMutableDictionary *dic = [@{@"Referer":@"http://api.maxjia.com/", @"User-Agent":@"Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36 ApiMaxJia/1.0", @"Host":@"api.lolmax.com", @"Connection":@"Keep-Alive", @"Accept-Encoding":@"gzip"} mutableCopy];
    [request setAllHTTPHeaderFields:dic];
    request.HTTPMethod = @"GET";
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self.model = [GamerPageModel getGamerModel:[[NSJSONSerialization JSONObjectWithData:data options:0 error:&error] valueForKey:@"result"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableV reloadData];
        });
    }] resume];
}

- (void)creatTableV{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 162) style:1];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.backgroundColor = [UIColor colorWithRed:225.f / 255.f green:230.f / 255.f blue:235.f / 255.f alpha:1];
    [self.tableV registerClass:[LatelyMatchTBcell class] forCellReuseIdentifier:@"lately"];
    [self.tableV registerClass:[CommonHearoTBcell class] forCellReuseIdentifier:@"common"];
    [self.tableV registerClass:[TitleCell class] forCellReuseIdentifier:@"recentTitle"];
    [self.tableV registerClass:[TitleCell class] forCellReuseIdentifier:@"commonTitle"];
    [self.view addSubview:self.tableV];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return self.model.recent_match_list.count + 1;
    }else{
        return self.model.hero_stat.count + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SummaryTBcell *summary = [[SummaryTBcell alloc] initWithStyle:0 reuseIdentifier:nil];
    LatelyMatchTBcell *lately = [tableView dequeueReusableCellWithIdentifier:@"lately"];
    CommonHearoTBcell *common = [tableView dequeueReusableCellWithIdentifier:@"common"];
    if (indexPath.section == 0) {
        summary.model = self.model;
        return summary;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            TitleCell *title = [tableView dequeueReusableCellWithIdentifier:@"recentTitle"];
            title.selectionStyle = UITableViewCellAccessoryNone;
            if (title.subviews.count == 3) {
                [title.titleView addSubview:[self creatRecentFirstCell]];
            }
            return title;
        }else{
        lately.model = self.model.recent_match_list[indexPath.row - 1];
        return lately;
        }
    }else{
        if (indexPath.row == 0) {
            TitleCell *title = [tableView dequeueReusableCellWithIdentifier:@"recentTitle"];
            if (title.subviews.count == 3) {
                [title.titleView addSubview:[self creatCommonFirstCell]];
            }
            return title;
        }else{
        common.model = self.model.hero_stat[indexPath.row - 1];
        return common;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
        head.backgroundColor = [UIColor colorWithRed:225.f / 256.f green:230.f / 256.f blue:235.f / 256.f alpha:1];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 5, 20)];
        line.backgroundColor = [UIColor colorWithRed:45 / 255.0 green:56 / 255.0 blue:65 / 255.0 alpha:1.000];
        [head addSubview:line];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 50, 20)];
        label.text = @"摘要";
        label.font = [UIFont systemFontOfSize:13];
        [head addSubview:label];
        UILabel *detailTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 75, 20)];
        detailTextLabel.textAlignment = 1;
        detailTextLabel.textColor = [UIColor colorWithRed:145 / 255.0 green:176 / 255.0 blue:205 / 255.0 alpha:0.7];
        detailTextLabel.font = [UIFont systemFontOfSize:12];
        detailTextLabel.text = self.model.area_name;
        [head addSubview:detailTextLabel];
        self.segmentView = [[SegmentView alloc] initWithItems:[@[@"全部", @"排位", @"匹配", @"大乱斗"] mutableCopy]];
        self.segmentView.frame = CGRectMake([UIScreen  mainScreen].bounds.size.width / 2, 0, [UIScreen mainScreen].bounds.size.width / 2, 30);
        self.segmentView.delegate = self;
        self.segmentView.pickArr = self.pickArr;
        [[self.segmentView valueForKey:@"collection"] reloadData];
        [head addSubview:self.segmentView];
        return head;
    }else if (section == 1){
        UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 5, 20)];
        line.backgroundColor = [UIColor colorWithRed:45 / 255.0 green:56 / 255.0 blue:65 / 255.0 alpha:1.000];
        [head addSubview:line];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 20)];
        label.text = @"最近比赛";
        label.font = [UIFont systemFontOfSize:13];
        [head addSubview:label];
        return head;
    }else{
        UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 5, 20)];
        line.backgroundColor = [UIColor colorWithRed:45 / 255.0 green:56 / 255.0 blue:65 / 255.0 alpha:1.000];
        [head addSubview:line];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 20)];
        label.text = @"常用英雄";
        label.font = [UIFont systemFontOfSize:13];
        [head addSubview:label];
        return head;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 60;
    }else{
        if ((indexPath.section == 1 && indexPath.row == 0)||(indexPath.section == 2 && indexPath.row == 0)) {
            return 20;
        }else{
            return 40;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (void)clickItem:(NSInteger)itemCount{
    for (int i = 0; i < self.pickArr.count; i++) {
        if (i == itemCount) {
            [self.pickArr setObject:@1 atIndexedSubscript:i];
        }else{
            [self.pickArr setObject:@0 atIndexedSubscript:i];
        }
    }
    self.segmentView.pickArr = self.pickArr;
}

- (UIView *)creatRecentFirstCell{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 2.5, 35, 15)];
    label1.text = @"英雄";
    label1.font = [UIFont systemFontOfSize:12];
    label1.textColor = [UIColor lightGrayColor];
    label1.textAlignment = 1;
    [view addSubview:label1];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(72.5, 2.5, 35, 15)];
    label2.text = @"结果";
    label2.textColor = [UIColor lightGrayColor];
    label2.font = [UIFont systemFontOfSize:12];
    [view addSubview:label2];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(125, 2.5, 35, 15)];
    label3.text = @"Level";
    label3.textColor = [UIColor lightGrayColor];
    label3.font = [UIFont systemFontOfSize:12];
    [view addSubview:label3];
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 160, 2.5, 75, 15)];
    label4.text = @"结束时间";
    label4.textColor = [UIColor lightGrayColor];
    label4.font = [UIFont systemFontOfSize:12];
    [view addSubview:label4];
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 75, 2.5, 75, 15)];
    label5.text = @"K/D/A";
    label5.textColor = [UIColor lightGrayColor];
    label5.font = [UIFont systemFontOfSize:12];
    [view addSubview:label5];
    return view;
}

- (UIView *)creatCommonFirstCell{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 35, 20)];
    label1.text = @"英雄";
    label1.textAlignment = 1;
    label1.font = [UIFont systemFontOfSize:12];
    label1.textColor = [UIColor lightGrayColor];
    [view addSubview:label1];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 35, 20)];
    label2.text = @"胜率";
    label2.font = [UIFont systemFontOfSize:12];
    label2.textColor = [UIColor lightGrayColor];
    [view addSubview:label2];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(185, 0, 35, 20)];
    label3.textAlignment = NSTextAlignmentRight;
    label3.font = [UIFont systemFontOfSize:12];
    label3.text = @"场次";
    label3.textColor = [UIColor lightGrayColor];
    [view addSubview:label3];
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 145, 0, 35, 20)];
    label4.text = @"MVP";
    label4.textAlignment = 1;
    label4.textColor = [UIColor lightGrayColor];
    label4.font = [UIFont systemFontOfSize:12];
    [view addSubview:label4];
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 95, 0, 50, 20)];
    label5.text = @"K/D/A";
    label5.font = [UIFont systemFontOfSize:12];
    label5.textColor = [UIColor lightGrayColor];
    [view addSubview:label5];
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
