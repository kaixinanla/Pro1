//
//  SjCollectionViewController.m
//  Pro20
//
//  Created by 盛嘉 on 2017/5/19.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "SjCollectionViewController.h"
#import "APPCollectionViewCell.h"
#import "UIImageView+WebCache.h"
//collectionViewCell行间距
//cell之间的约束间距与行间距不冲突,均会以较大的一方为基准
static CGFloat const minSpacingForLine= 23.0f;
//collectionViewSection行间距
static CGFloat const minSpacingForSection= 20.0f;
//collectionViewCell上间距
static CGFloat const marginTop=0.0f;
//collectionViewCell左间距
static CGFloat const marginLeft=0.0f;
//collectionViewCell底间距
static CGFloat const marginBottom=0.0f;
//collectionViewCell右间距
static CGFloat const marginRight=0.0f;
//collectionViewCell每行最大个数
static NSInteger const maxCountInRow=3;

@interface SjCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) NSArray *images;

@end

@implementation SjCollectionViewController



- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.images = @[@"http://pic.qiantucdn.com/58pic/17/89/16/01s58PICJ47_1024.jpg",@"http://img5.niutuku.com/phone/1212/2851/2851-niutuku.com-13607.jpg",@"http://s9.knowsky.com/bizhi/l/15001-25000/20095291467748471557.jpg",@"http://pic.58pic.com/58pic/15/20/60/86I58PICmDN_1024.jpg",@"http://www.mengtu.cc/uploads/allimg/150525/1-150525235I0.jpg"];
  
  
  [self.collectionView registerNib:[UINib nibWithNibName:@"APPCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"APPCollectionViewCell"];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  
  
  return CGSizeMake((self.view.bounds.size.width  - minSpacingForLine * (maxCountInRow - 1) - marginLeft - marginRight) / maxCountInRow ,(self.view.bounds.size.width  - minSpacingForLine * (maxCountInRow - 1) - marginTop - marginBottom) / maxCountInRow);
  
  
}

- (IBAction)clearAction:(UIButton *)sender{
  
  
  [[SDImageCache sharedImageCache] clearMemory];
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  
  return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  
  return self.images.count  ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  //    APPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"APPCollectionViewCell" forIndexPath:indexPath];
  //    // Configure the cell
  //    cell.backgroundColor  = [UIColor clearColor];
  //
  //    UIImageView *imageView = [[UIImageView alloc]initWithFrame:cell.bounds];
  ////    NSString *imageName = [NSString stringWithFormat:@"image%zi.ico",indexPath.row + 1];
  ////    imageView.image = [UIImage imageNamed:imageName];
  //
  //
  //    [cell addSubview:imageView];
  //
  //    return cell;
  APPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"APPCollectionViewCell" forIndexPath:indexPath];
  
  NSString *imageUrl = self.images[indexPath.row];
  
  [cell.iconView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"image1"]];

  return cell;
  
}


/**
 
 
 
 
 ...
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 static NSString *MyIdentifier = @"MyIdentifier";
 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
 
 if (cell == nil) {
 cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier]
 autorelease];
 }
 
 // Here we use the provided sd_setImageWithURL: method to load the web image
 // Ensure you use a placeholder image otherwise cells will be initialized with no image
 [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://example.com/image.jpg"]
 placeholderImage:[UIImage imageNamed:@"placeholder"]];
 
 cell.textLabel.text = @"My Text";
 return cell;
 }
 
 
 */
#pragma mark <UICollectionViewDelegate>
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
  //    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
  UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
  headView.backgroundColor = [UIColor clearColor];
  UILabel *headLabel = (UILabel *)[headView viewWithTag:100];
  headLabel.text = @"精彩频道|FEATURED";
  return headView;
  //    }else{
  //        UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot" forIndexPath:indexPath];
  //        footView.backgroundColor = [UIColor grayColor];
  //        UILabel *footLabel = (UILabel *)[footView viewWithTag:200];
  //        footLabel.text = @"sectionFoot 加载更多";
  //        return footView;
  //    }
  
}




@end
