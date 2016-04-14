//
//  TeamMateVC.m
//  Max+2x
//
//  Created by dllo on 16/4/6.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "TeamMateVC.h"
#import "TeamMateModel.h"
#import "TeamMateTBCell.h"
#import "TitleCell.h"
@interface TeamMateVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableV;

@property (nonatomic, retain) NSMutableArray *teamArray;

@property (nonatomic, retain) NSMutableArray *enemyArray;

@end

@implementation TeamMateVC



- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 162);
    [self creatTableV];
    [self getTaskData];
}

- (void)getTaskData{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.lolmax.com/api/player/teammates/?area_id=%@&uid=%@&pkey=MTQ1ODg3NzY0Mi42MTU5NDE4OTg4ODBfMXV6Z3drb251dW1pcHJtc3M__&phone_num=15941898880&game_type=lol&imei=355021060246177&os_type=Android&os_version=5.0&version=3.2.0", self.areaId, [self.name stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLQueryAllowedCharacterSet]]]]];
    NSMutableDictionary *dic = [@{@"Referer":@"http://api.maxjia.com/", @"User-Agent":@"Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36 ApiMaxJia/1.0", @"Host":@"api.lolmax.com", @"Connection":@"Keep-Alive", @"Accept-Encoding":@"gzip"} mutableCopy];
    [request setAllHTTPHeaderFields:dic];
    request.HTTPMethod = @"GET";
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSMutableDictionary *dataDic = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] valueForKey:@"result"];
        self.teamArray = [TeamMateModel getTeamMateModel:[dataDic valueForKey:@"team"]];
        self.enemyArray = [TeamMateModel getTeamMateModel:[dataDic valueForKey:@"enemy"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableV reloadData];
        });
    }] resume];
}

- (void)creatTableV{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 162) style:0];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.tableV registerClass:[TeamMateTBCell class] forCellReuseIdentifier:@"teamMate"];
    [self.tableV registerClass:[TitleCell class] forCellReuseIdentifier:@"title"];
    [self.view addSubview:self.tableV];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.teamArray.count + 1;
    }else{
        return self.enemyArray.count + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TeamMateTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"teamMate"];
    TitleCell *title = [tableView dequeueReusableCellWithIdentifier:@"title"];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (title.subviews.count == 1) {
                [title addSubview:[self creatTitleView]];
            }
            return title;
        }else{
            cell.model = self.teamArray[indexPath.row - 1];
            return cell;
        }
    }else{
        if (indexPath.row == 0) {
            if (title.subviews.count == 1) {
                [title addSubview:[self creatTitleView]];
            }
            return title;
        }else{
            cell.model = self.enemyArray[indexPath.row - 1];
            return cell;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 5, 20)];
        line.backgroundColor = [UIColor colorWithRed:45 / 255.0 green:56 / 255.0 blue:65 / 255.0 alpha:1.000];
        [head addSubview:line];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 20)];
        label.text = @"队友统计";
        label.font = [UIFont systemFontOfSize:13];
        [head addSubview:label];
        return head;
    }else{
        UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 5, 20)];
        line.backgroundColor = [UIColor colorWithRed:45 / 255.0 green:56 / 255.0 blue:65 / 255.0 alpha:1.000];
        [head addSubview:line];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 20)];
        label.text = @"对手统计";
        label.font = [UIFont systemFontOfSize:13];
        [head addSubview:label];
        return head;
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

- (UIView *)creatTitleView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 2 - 20, 20)];
    label1.text = @"玩家";
    label1.textAlignment = 1;
    label1.font = [UIFont systemFontOfSize:12];
    label1.textColor = [UIColor lightGrayColor];
    [view addSubview:label1];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2, 0, 75, 20)];
    label2.text = @"胜率";
    label2.font = [UIFont systemFontOfSize:12];
    label2.textColor = [UIColor lightGrayColor];
    [view addSubview:label2];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 0, 50, 20)];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.font = [UIFont systemFontOfSize:12];
    label3.text = @"场次";
    label3.textColor = [UIColor lightGrayColor];
    [view addSubview:label3];
    return view;
}

@end
