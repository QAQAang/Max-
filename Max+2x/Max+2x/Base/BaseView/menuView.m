//
//  menuView.m
//  Max_2x_kj
//
//  Created by dllo on 16/3/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "menuView.h"
#import "menuCollectionCell.h"
#import "Arrow.h"
@interface menuView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) UICollectionView *menuCollection;

@property (nonatomic, retain) Arrow *scrollArrow;

@property (nonatomic, assign) BOOL pick;

@property (nonatomic, retain) NSMutableArray *menuArr;

@end

@implementation menuView

- (void)setMenuArr:(NSMutableArray *)menuArr{
    _menuArr = menuArr;
    [self.menuCollection reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame menuArr:(NSMutableArray *)array{
    self = [super initWithFrame:frame];
    if (self) {
        if (array != nil) {
            self.menuArr = array;
        }
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.pick = YES;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width / self.menuArr.count, 20);
    layout.sectionInset = UIEdgeInsetsMake(2, 0, 0, 0);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    self.menuCollection = [[UICollectionView alloc] initWithFrame:CGRectMake( 0, 0, [UIScreen mainScreen].bounds.size.width, 30) collectionViewLayout:layout];
    self.menuCollection.delegate = self;
    self.menuCollection.dataSource = self;
    self.menuCollection.backgroundColor = [UIColor colorWithRed:56 / 255.0 green:65 / 255.0 blue:73 / 255.0 alpha:1.000];
    self.scrollArrow = [[Arrow alloc] initWithFrame:CGRectMake(0, 24, [UIScreen mainScreen].bounds.size.width / self.menuArr.count, 6)];
    [self.menuCollection registerClass:[menuCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    self.scrollArrow.backgroundColor = [UIColor clearColor];
    [self addSubview:self.menuCollection];
    [self addSubview:self.scrollArrow];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.menuArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    menuCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.menuArr[indexPath.row];
    if (indexPath.row == 0) {
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.pick = NO;
    for (int i = 0; i < self.menuArr.count; i++) {
        [[self.menuCollection cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]] setValue:[UIColor colorWithRed:241.f / 256.f green:242.f / 256.f blue:242.f / 256.f alpha:0.5] forKeyPath:@"textLabel.textColor"];
        if (i == indexPath.row) {
            [[self.menuCollection cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]] setValue:[UIColor whiteColor] forKeyPath:@"textLabel.textColor"];
        }
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollArrow.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / self.menuArr.count * indexPath.row, 24, [UIScreen mainScreen].bounds.size.width / self.menuArr.count, 6);
    } completion:^(BOOL finished) {
        self.pick = YES;
    }];
    [self.delegate clickItemChangeOffset:indexPath.row];
}

// 改变箭头方法 通过监听调用
- (void)receiveOffset:(CGFloat)contentOffset_x{
    if (self.pick == YES) {
    CGFloat x = contentOffset_x / ([UIScreen mainScreen].bounds.size.width * self.menuArr.count) * ([UIScreen mainScreen].bounds.size.width);
    self.scrollArrow.frame = CGRectMake(x, 24, [UIScreen mainScreen].bounds.size.width / self.menuArr.count, 6);
    }
    CGFloat x = contentOffset_x / [UIScreen mainScreen].bounds.size.width;
    for (int i = 0; i < self.menuArr.count; i++) {
        [[self.menuCollection cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]] setValue:[UIColor colorWithRed:241.f / 256.f green:242.f / 256.f blue:242.f / 256.f alpha:0.5] forKeyPath:@"textLabel.textColor"];
    }
    if (x == 0.f || x == 1.f || x == 2.f || x == 3.f) {
        [[self.menuCollection cellForItemAtIndexPath:[NSIndexPath indexPathForItem:x inSection:0]] setValue:[UIColor whiteColor] forKeyPath:@"textLabel.textColor"];
    }
}

@end
