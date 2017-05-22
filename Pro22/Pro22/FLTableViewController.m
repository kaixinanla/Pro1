//
//  FLTableViewController.m
//  Pro22
//
//  Created by 盛嘉 on 2017/5/22.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "FLTableViewController.h"
#import "FLTableViewCell.h"
#import "HDTableViewCell.h"
#import "MJRefresh.h"
@interface FLTableViewController ()
@property (copy , nonatomic) NSArray *idleImages;
@property (strong , nonatomic) NSMutableArray *dataArry;

@end

@implementation FLTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.dataArry = [NSMutableArray array];
  [self.tableView registerNib:[UINib nibWithNibName:@"FLTableViewCell" bundle:nil] forCellReuseIdentifier:@"FLTableViewCell"];
  [self.tableView registerNib:[UINib nibWithNibName:@"HDTableViewCell" bundle:nil] forCellReuseIdentifier:@"HDTableViewCell"];
  __weak typeof (self)weakSelf =self;
  
  
  self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];

  self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
    [weakSelf loadNoreData];
  }];
 
  NSURL *url = [NSURL URLWithString:@"http://hzt.idoool.com/welfareactivitylist"];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  request.HTTPMethod = @"POST";
  NSString *httpBody =[NSString stringWithFormat:@"offset=%@&limit=5&type=1"];
  request.HTTPBody = [httpBody dataUsingEncoding:NSUTF8StringEncoding];
  NSURLSession *session = [NSURLSession sharedSession];
  NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    dispatch_sync(dispatch_get_main_queue()n, ^{
      com
    })
  }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadNewData{
  
}
- (void)loadNoreData{
  
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 0) {
    return 1;
  }else{
    return 2;
  }
  
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    HDTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"FLTableViewCell" forIndexPath:indexPath];
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell1;
  }else{
    FLTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"HDTableViewCell" forIndexPath:indexPath];
    cell2.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell2;
  }
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  if (indexPath.section == 0) {
    return 300;
  }else{
    return 450;
  }
}


@end
