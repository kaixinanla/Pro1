//
//  APPCollectionViewCell.m
//  Pro20.1
//
//  Created by 盛嘉 on 2017/5/19.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "APPCollectionViewCell.h"
@interface APPCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end
@implementation APPCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
