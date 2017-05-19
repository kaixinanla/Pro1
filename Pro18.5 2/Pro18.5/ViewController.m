//
//  ViewController.m
//  Pro18.5
//
//  Created by 盛嘉 on 2017/5/18.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "ViewController.h"
#import "ImageScroll.h"
@interface ViewController ()

@end
    
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    scrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*3, [UIScreen mainScreen].bounds.size.height);
    
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.tag = INT_MAX;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
//    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    _imageView.image = [UIImage imageNamed:@"image1.ico"];
//    [scrollView addSubview:_imageView];
    
   
    int _x = 0;
    for (int index = 0; index <4; index ++) {
        ImageScroll *imgScrollView = [[ImageScroll alloc]initWithFrame:CGRectMake(0 + _x, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        NSString *imgName = [NSString stringWithFormat:@"image%d.ico", index +1];
        imgScrollView.tag = index;
        imgScrollView.imageView.image = [UIImage imageNamed:imgName];
        [scrollView addSubview: imgScrollView];
        _x += [UIScreen mainScreen].bounds.size.width;
    
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
int pre = 0;
#pragma mark - ScrollView
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int current = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    ImageScroll *imgScrollView = (ImageScroll *)[scrollView viewWithTag:pre];
    if (current != pre && imgScrollView.zoomScale >1) {
        imgScrollView.zoomScale = 1;
    }
    pre = current;
}
@end
