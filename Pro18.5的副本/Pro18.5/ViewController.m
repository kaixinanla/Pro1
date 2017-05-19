//
//  ViewController.m
//  Pro18.5
//
//  Created by 盛嘉 on 2017/5/18.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end
    
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    scrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*3, [UIScreen mainScreen].bounds.size.height);
    scrollView.maximumZoomScale = 2.0;
    scrollView.minimumZoomScale = 1.0;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _imageView.image = [UIImage imageNamed:@"image1.ico"];
    [scrollView addSubview:_imageView];
    
   
//    float _x = 0;
//    for (int index = 0; index <4; index ++) {
//        _imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0 + _x, 0, [UIScreen mainScreen].bounds.size.width - 20, [UIScreen mainScreen].bounds.size.height)];
//        NSString *imageName = [NSString stringWithFormat:@"image%d.ico" , index +1];
//        _imageView.image = [UIImage imageNamed:imageName];
//        [scrollView addSubview:_imageView];
//        _x +=[UIScreen mainScreen].bounds.size.width;
    
//    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ScrollView
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}
int pre = 0;
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    int current = s
//}
@end
