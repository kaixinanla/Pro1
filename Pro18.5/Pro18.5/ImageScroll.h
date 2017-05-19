//
//  ImageScroll.h
//  Pro18.5
//
//  Created by 盛嘉 on 2017/5/18.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageScroll : UIScrollView <UIScrollViewDelegate>
{
    @private
    UIImageView *_imageView;
}
@property (nonatomic ,retain) UIImageView *imageView;
@end
