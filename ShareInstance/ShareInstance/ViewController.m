//
//  ViewController.m
//  ShareInstance
//
//  Created by 盛嘉 on 2017/5/25.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "ViewController.h"
#import "AdressBook.h"
@interface ViewController ()
@property (assign , nonatomic) int height;
@property (strong , nonatomic) NSObject *object;
@property (strong , nonatomic) NSMutableArray *arrymM;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  AdressBook *object1 = [AdressBook shareInstance];
  NSLog(@"%@",object1);
  AdressBook *object2 = [[AdressBook alloc]init];
  NSLog(@"%@",object2);
  AdressBook *object3 = [AdressBook new];
  NSLog(@"%@",object3);
  
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
