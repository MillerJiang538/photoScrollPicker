//
//  GJNewsImageScrollViewController.m
//  ImageScrollManger
//
//  Created by Miller on 2018/5/30.
//  Copyright © 2018年 Miller. All rights reserved.
//

#import "GJNewsImageScrollViewController.h"
#import "GJImagePreCollectionViewCell.h"

@interface GJNewsImageScrollViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *_collectionView;
    UICollectionViewFlowLayout *_layout;
}
@end

@implementation GJNewsImageScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configCollectionView {
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _layout.minimumLineSpacing = 0;
    _layout.minimumInteritemSpacing = 0;
    _layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    _collectionView.backgroundColor = [UIColor blackColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.scrollsToTop = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.contentOffset = CGPointMake(0, 0);
    [self.view addSubview:_collectionView];
    _collectionView.frame = self.view.bounds;
    [_collectionView registerClass:[GJImagePreCollectionViewCell class] forCellWithReuseIdentifier:@"GJImagePreCollectionViewCell"];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GJImagePreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GJImagePreCollectionViewCell" forIndexPath:indexPath];
    cell.imageUrl = [@[@"http://mpic.tiankong.com/323/4c3/3234c3ff6d76cde3982be638cfc77329/640.jpg",@"http://mpic.tiankong.com/169/e7b/169e7bc99a479da4fefb1278bd549ca6/640.jpg",@"http://mpic.tiankong.com/3ab/df8/3abdf8541da61c9e9a97eea157b48d4d/bld017006.jpg"] objectAtIndex:indexPath.row];
//    cell.imageUrl = [[NSBundle mainBundle] pathForResource:@[@"bld017006",@"qj9103449042",@"wavebreak626860"][indexPath.row] ofType:@".jpg"];
    return cell;
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
