//
//  SegmentView.m
//  Max+2x
//
//  Created by dllo on 16/3/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "SegmentView.h"
#import "SegmentCell.h"
#import "AA_adaptivelyHW.h"

@interface SegmentView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) UICollectionView *collection;

@property (nonatomic, retain) NSMutableArray *textArr;

@end

@implementation SegmentView



- (NSMutableArray *)pickArr{
    if (_pickArr == nil) {
        _pickArr = [NSMutableArray array];
    }
    return _pickArr;
}

- (instancetype)initWithItems:(NSMutableArray *)itmeArr{
    self = [super init];
    if (self) {
        [self creatCollection:itmeArr];
    }
    return self;
}

- (void)creatCollection:(NSMutableArray *)arr{
    self.textArr = arr;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 0);
    self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 8 * self.textArr.count, 30) collectionViewLayout:layout];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    self.collection.backgroundColor = [UIColor clearColor];
    [self.collection registerClass:[SegmentCell class] forCellWithReuseIdentifier:@"cell"];
    [self addSubview:self.collection];
  //  [self.collection reloadData];
   // [self.collection selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:0];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.textArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SegmentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSLog(@"%lf", [AA_adaptivelyHW getWidth:self.textArr[indexPath.row] :15 :13]);
    cell.textLabel.frame = CGRectMake(0, 0, [AA_adaptivelyHW getWidth:self.textArr[indexPath.row] :15 :13] + 10, 20);
    cell.textLabel.text = self.textArr[indexPath.row];
    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.shadowOpacity = 0.3;
    cell.layer.shadowRadius = 1;
    cell.layer.shadowOffset = CGSizeMake(0.5, 0.5);
    if ([self.pickArr[indexPath.row]  isEqual:@0]) {
        cell.alpha = 0.1;
    }else{
        cell.alpha = 1;
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake([AA_adaptivelyHW getWidth:self.textArr[indexPath.row] :15 :13] + 10, 20);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SegmentCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [self.pickArr setObject:@1 atIndexedSubscript:indexPath.row];
    cell.alpha = 1;
    [self.delegate clickItem:indexPath.row];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    SegmentCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [self.pickArr setObject:@0 atIndexedSubscript:indexPath.row];
    cell.alpha = 0.1;
}

@end
