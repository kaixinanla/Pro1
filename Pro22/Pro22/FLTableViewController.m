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
#import "UIImageView+WebCache.h"
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
  
  
  self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    [weakSelf loadNewData];
  }];

  self.tableView.mj_footer =[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
    [weakSelf loadNoreData];
  }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadNewData{
  __weak typeof (self)weakSelf = self;
  [self requestWelfareactivitylistByoffset:@"0" completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    [weakSelf.tableView.mj_header endRefreshing];
    if (error != nil) {
      return ;
    }
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSNumber *status = dic[@"status"];
    if (status.integerValue != 1) {
      return;
    }
    NSArray *arry = dic[@"data"][@"list"];
    weakSelf.dataArry = [NSMutableArray arrayWithArray:arry];
    [weakSelf.tableView reloadData];
  }];
}
- (void)loadNoreData{
  __weak typeof (self)weakSelf = self;
  NSString *offset = [NSString stringWithFormat:@"%zi",self.dataArry.count];
  [self requestWelfareactivitylistByoffset:offset completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    [weakSelf.tableView.mj_footer endRefreshing];
    if (error != nil) {
      return ;
    }
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSArray *arry = dic[@"data"][@"list"];
    [weakSelf.dataArry addObjectsFromArray:arry];
    [weakSelf.tableView reloadData];
  }];
  
}
- (void)requestWelfareactivitylistByoffset:(NSString *)offset completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler{
  
  
  NSURL *url = [NSURL URLWithString:@"http://hzt.idoool.com/welfareactivitylist"];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  request.HTTPMethod = @"POST";
  NSString *httpBody = [NSString stringWithFormat:@"offset=%@&limit=5&type=1",offset];
  request.HTTPBody = [httpBody dataUsingEncoding:NSUTF8StringEncoding];
  
  NSURLSession *session = [NSURLSession sharedSession];
  // 由于要先对request先行处理,我们通过request初始化task
  NSLog(@"%@", completionHandler);
  NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
    dispatch_async(dispatch_get_main_queue(), ^{
      
      completionHandler(data,response,error);
      
    });
    
  }];
  
  
  [task resume];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 0) {
    return 1;
  }else{
    return self.dataArry.count;
  }
  
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    HDTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"FLTableViewCell" forIndexPath:indexPath];
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = self.dataArry[indexPath.row];
    NSString *imageUrl = dic[@"coverImageUrl"];
    [cell1.hdiconView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    return cell1;
  }else{
    FLTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"HDTableViewCell" forIndexPath:indexPath];
    cell2.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = self.dataArry[indexPath.row];
    NSString *imageUrl = dic[@"coverImageUrl"];
    [cell2.hliconView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    return cell2;
  }
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  if (indexPath.section == 0) {
    return 300;
  }else{
    return 200;
  }
}


@end
