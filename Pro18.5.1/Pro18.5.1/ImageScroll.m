//
//  ImageScroll.m
//  Pro18.5.1
//
//  Created by 盛嘉 on 2017/5/26.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "ImageScroll.h"

@implementation ImageScroll 
- (id)initWithFrame:(CGRect)frame{
  if (self = [super initWithFrame:frame]) {
    self.maximumZoomScale = 2.5;
    self.minimumZoomScale = 0.5;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    self.delegate = self;
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoomInOrOut:)];
    doubleTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTap];
  }
  return self;
}
#pragma mark - UIScrollView Delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
  return _imageView;
}
#pragma mark - Target Action
- (void)zoomInOrOut:(UIGestureRecognizer *)tapGesture{
  if (self.zoomScale >= 2.5) {
    [self setZoomScale:1 animated:YES];
  }else{
    CGPoint point = [tapGesture locationInView:self];
    [self zoomToRect:CGRectMake(point.x - 40, point.y - 40, 80, 80) animated:YES];
  }
}
@end
