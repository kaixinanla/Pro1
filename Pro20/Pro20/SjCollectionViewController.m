//
//  SjCollectionViewController.m
//  Pro20
//
//  Created by 盛嘉 on 2017/5/19.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "SjCollectionViewController.h"
#import "APPCollectionViewCell.h"
@interface SjCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation SjCollectionViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self.collectionView registerNib:[UINib nibWithNibName:@"APPCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"APPCollectionViewCell"];
//    self.collectionView.pagingEnabled = YES;
//    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithTitle:@"添加"
//                                                                style:UIBarButtonItemStylePlain
//                                                               target:self
//                                                               action:@selector(addItemBtnClick:)];
    
//    self.navigationItem.rightBarButtonItem = btnItem;
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(200.0, 200.0);
    
}

//- (void)ddItemBtnClick:(UIBarButtonItem *)btnItem{
//    [collectionView performBatchUpdates:^{
//        // 构造一个indexPath
//        NSIndexPath *indePath = [NSIndexPath indexPathForItem:_section0Array.count inSection:0];
//        [_collectionView insertItemsAtIndexPaths:@[indePath]]; // 然后在此indexPath处插入给collectionView插入一个item
//        [_section0Array addObject:@"x"]; // 保持collectionView的item和数据源一致
//    } completion:nil];
//}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 10  ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    APPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"APPCollectionViewCell" forIndexPath:indexPath];
    // Configure the cell
    cell.backgroundColor  = [UIColor clearColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:cell.bounds];
    NSString *imageName = [NSString stringWithFormat:@"image%d.ico",indexPath.row + 1];
    imageView.image = [UIImage imageNamed:imageName];
    [cell addSubview:imageView];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
        headView.backgroundColor = [UIColor blueColor];
        UILabel *headLabel = (UILabel *)[headView viewWithTag:100];
        headLabel.text = @"sectionHead";
        return headView;
    }else{
        UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot" forIndexPath:indexPath];
        footView.backgroundColor = [UIColor grayColor];
        UILabel *footLabel = (UILabel *)[footView viewWithTag:200];
        footLabel.text = @"sectionFoot 加载更多";
        return footView;
    }
    
}


    

//}
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
