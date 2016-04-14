//
//  mineViewController.m
//  Max_2x_kj
//
//  Created by dllo on 16/3/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "mineViewController.h"
#import "RoleTableViewCell.h"
#import "RecordTableViewCell.h"
#import "Recent_game.h"
#import "mineModel.h"
#import <UIImageView+WebCache.h>
#import "GamerMainPageVC.h"
#import "MatchViewController.h"
@interface mineViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableV;

@property (nonatomic, retain) mineModel *mineModel;

@end

@implementation mineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getTaskData];
    [self creatTableV];
}

- (void)getTaskData{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://api.lolmax.com/api/lol/account/home/?&pkey=MTQ1ODg3NzY0Mi42MTU5NDE4OTg4ODBfMXV6Z3drb251dW1pcHJtc3M__&phone_num=15941898880&game_type=lol&imei=355021060246177&os_type=Android&os_version=5.0&version=3.2.0"]];
    // 请求头
//    Referer	http://api.maxjia.com/
//    User-Agent	Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36 ApiMaxJia/1.0
//    Host	api.lolmax.com
//    Connection	Keep-Alive
//    Accept-Encoding	gzip
    NSMutableDictionary *dic = [@{@"Referer":@"http://api.maxjia.com/", @"User-Agent":@"Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36 ApiMaxJia/1.0", @"Host":@"api.lolmax.com", @"Connection":@"Keep-Alive", @"Accept-Encoding":@"gzip"} mutableCopy];
    [request setAllHTTPHeaderFields:dic];
    request.HTTPMethod = @"GET";
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self.mineModel = [mineModel getModel:[[NSJSONSerialization JSONObjectWithData:data options:0 error:&error] valueForKey:@"result"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableV reloadData];
        });
    }] resume];
}

- (void)creatTableV{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 44) style:1];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.backgroundColor = [UIColor colorWithRed:241.f / 256.f green:242.f / 256.f blue:242.f / 256.f alpha:1];
    [self.tableV registerClass:[RoleTableViewCell class] forCellReuseIdentifier:@"role"];
    [self.tableV registerClass:[RecordTableViewCell class] forCellReuseIdentifier:@"record"];
    [self.view addSubview:self.tableV];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return self.mineModel.recent_games.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RoleTableViewCell *role = [tableView dequeueReusableCellWithIdentifier:@"role"];
    role.selectionStyle = UITableViewCellAccessoryNone;
    RecordTableViewCell *record = [tableView dequeueReusableCellWithIdentifier:@"record"];
    record.selectionStyle = UITableViewCellAccessoryNone;
    if (indexPath.section == 0) {
        role.textLabelName.text = [[self.mineModel.bind_info valueForKey:@"player_info"] valueForKey:@"name"];
        [role.imageViewHead sd_setImageWithURL:[NSURL URLWithString:[[self.mineModel.bind_info valueForKey:@"player_info"] valueForKey:@"image_url"]] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        role.skipView.textLabel.text = @"战绩详情";
        return role;
    }else{
        record.model = self.mineModel.recent_games[indexPath.row];
        return record;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 5, 20)];
        line.backgroundColor = [UIColor colorWithRed:45 / 255.0 green:56 / 255.0 blue:65 / 255.0 alpha:1.000];
        [head addSubview:line];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, [UIScreen mainScreen].bounds.size.width, 20)];
        label.text = @"绑定角色";
        label.font = [UIFont systemFontOfSize:13];
        [head addSubview:label];
        return head;
    }else{
        UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 5, 20)];
        line.backgroundColor = [UIColor colorWithRed:45 / 255.0 green:56 / 255.0 blue:65 / 255.0 alpha:1.000];
        [head addSubview:line];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, [UIScreen mainScreen].bounds.size.width, 20)];
        label.text = @"我的比赛";
        label.font = [UIFont systemFontOfSize:13];
        [head addSubview:label];
        return head;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 && indexPath.section == 0) {
        GamerMainPageVC *gamerMain = [[GamerMainPageVC alloc] init];
        gamerMain.name = [[self.mineModel.bind_info valueForKey:@"player_info"] valueForKey:@"name"];
        gamerMain.areaId = [[self.mineModel.bind_info valueForKey:@"player_info"] valueForKey:@"area_id"];
        [self.navigationController pushViewController:gamerMain animated:YES];
    }else if (indexPath.section == 1){
        Recent_game *model = self.mineModel.recent_games[indexPath.row];
        MatchViewController *matchVc = [[MatchViewController alloc] init];
        matchVc.areaId = model.area_id;
        matchVc.gameId = model.game_id;
        [self.navigationController pushViewController:matchVc animated:YES];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
