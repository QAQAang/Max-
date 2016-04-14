//
//  CollectViewController.m
//  Max+2x
//
//  Created by 谷萌雨 on 16/3/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "CollectViewController.h"



#import "findDetailViewController.h"
#import "findModel.h"
#import "GMYDataBaseManager.h"


@interface CollectViewController ()<UITableViewDataSource, UITableViewDelegate, GMYReadingDetailViewControllerDelegate>

@property(nonatomic, retain)UITableView *collectTableView;

@property (nonatomic, retain) NSMutableArray *array;

@end

@implementation CollectViewController



- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.array = [NSMutableArray array];
    
    self.array = [[GMYDataBaseManager shareDataBaseManager] selectAllNewsModel];
    if (self.array.count == 0) {
        UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height / 2.5, [[UIScreen mainScreen] bounds].size.width, 50)];
        myLabel.text = @"还没有收藏,快去看新闻吧~";
        myLabel.textAlignment = UITextAlignmentCenter;
        myLabel.textColor = [UIColor lightGrayColor];
        [self.view addSubview:myLabel];

        
    }else{
        
        [self createTableView];
        
        
        
        
        //        self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
#pragma mark -- 查询数据库中所有新闻和视频的名字
        [self.collectTableView reloadData];
        
    }
    [self.collectTableView reloadData];
    
}







- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"我的收藏";
    

    // 设置导航栏右侧按钮
    UIImage *imageBack = [UIImage imageNamed:@"iconfont-fanhui"];
    // 取消图片渲染
    imageBack = [imageBack imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:imageBack style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonAction:)];
    

    self.array = [[GMYDataBaseManager shareDataBaseManager] selectAllNewsModel];


}


#pragma mark -- 编辑第三步
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

#pragma mark -- 编辑第四步 设置编辑类型
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

#pragma mark -- 编辑第五步: 实现编辑逻辑
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    findModel *findMod = [self.array objectAtIndex:indexPath.row];
    
    // 删除数据库中的数据
    [[GMYDataBaseManager shareDataBaseManager] deleteNewsModelFromTable:findMod.title];
    // 删除数组
    [self.array removeObjectAtIndex:indexPath.row];
    
    // 删除整个cell
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationLeft];
    
    [self.collectTableView reloadData];
    
}




- (void)createTableView{
    
    
    self.collectTableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    [self.view addSubview:self.collectTableView];

    
    self.collectTableView.dataSource = self;
    self.collectTableView.delegate = self;
    
    [self.collectTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
}




-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    findModel *findMod = [self.array objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    //    cell.textLabel.text = @"收藏";
    cell.textLabel.text = findMod.title;
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    findModel *findMod = [self.array objectAtIndex:indexPath.row];
    
    findDetailViewController *findDetailVC = [[findDetailViewController alloc] init];
    
    findDetailVC.newsDetailDelegate = self;
    
    [self.navigationController pushViewController:findDetailVC animated:YES];
    
    findDetailVC.findM = findMod;
    
    findDetailVC.indexPath = indexPath;
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


- (void)deleteFromCollection:(NSIndexPath *)indexPath{
    
    [self.array removeObjectAtIndex:indexPath.row];
    [self.collectTableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationLeft];
    
    [self.collectTableView reloadData];
    
    
}






-(void)leftButtonAction:(UIBarButtonItem *)barBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
