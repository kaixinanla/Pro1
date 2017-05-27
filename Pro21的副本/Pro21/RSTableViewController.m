//
//  RSTableViewController.m
//  Pro21
//
//  Created by 盛嘉 on 2017/5/20.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "RSTableViewController.h"
#import "SJTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "AFNetworkReachabilityManager.h"
@interface RSTableViewController () <UITableViewDelegate,UITableViewDataSource>

@property (copy , nonatomic) NSArray *idleImages;
@property (copy , nonatomic) NSMutableArray *pullingImages;
@property (copy , nonatomic) NSMutableArray *refreshingImages;

@property (strong, nonatomic) UIImageView *imageview;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation RSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.dataArray = [NSMutableArray array];
  
  [self.tableView registerNib:[UINib nibWithNibName:@"SJTableViewCell" bundle:nil] forCellReuseIdentifier:@"SJTableViewCell"];

  
     _idleImages = @[[UIImage imageNamed:@"box"]];
    _refreshingImages = @[[UIImage imageNamed:@"deliveryStaff0"],
                      [UIImage imageNamed:@"deliveryStaff1"],
                      [UIImage imageNamed:@"deliveryStaff2"],
                      [UIImage imageNamed:@"deliveryStaff3"]
                      ];


  
  MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
  [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
  [header setTitle:@"释放开始刷新哦～～" forState:MJRefreshStatePulling];
  [header setTitle:@"正在快马加鞭地刷新着呢" forState:MJRefreshStateRefreshing];
  [header setImages:_idleImages forState:MJRefreshStateIdle];
  [header setImages:_refreshingImages forState:MJRefreshStateRefreshing];
  self.tableView.mj_header = header;
  [self loadNewData];
  __weak typeof(self) weakSelf = self;
  self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
    [weakSelf loadNoreData];
  }];

}


/**
 请求获取最新的数据
 */
- (void)loadNewData{
  __weak typeof (self)weakSelf = self;
  [self requestWelfareactivitylistByoffset:@"0" successBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    [weakSelf.tableView.mj_header endRefreshing];
   // NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    
    
    NSArray *arry = responseObject[@"data"][@"list"];
    NSNumber *status = responseObject[@"status"];
    if (status.integerValue != 1) {
      return;
    }
    
    weakSelf.dataArray = [NSMutableArray arrayWithArray:arry];
    [weakSelf.tableView reloadData];
  } failureBlock:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    if (error != nil) {
      return ;
    }
   
  }];

//  {
//    [weakSelf.tableView.mj_header endRefreshing];
//    if (error != nil) {
//      return ;
//    }
//   NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//    
//    NSNumber *status = dic[@"status"];
//    if (status.integerValue != 1) {
//      return;
//    }
//    NSArray *arry = dic[@"data"][@"list"];
//    weakSelf.dataArray = [NSMutableArray arrayWithArray:arry];
//    [weakSelf.tableView reloadData];
//  }];
}
- (void)loadNoreData{
//  __weak typeof (self)weakSelf = self;
//  NSString *offset = [NSString stringWithFormat:@"%zi",self.dataArray.count];
//  
//  [self requestWelfareactivitylistByoffset:offset completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//    [weakSelf.tableView.mj_footer endRefreshing];
//    if (error != nil) {
//      return ;
//    }
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//    NSArray *arry = dic[@"data"][@"list"];
//    [weakSelf.dataArray addObjectsFromArray:arry];
//    [weakSelf.tableView reloadData];
//  }];
  __weak typeof (self)weakSelf = self;
  NSString *offest = [NSString stringWithFormat:@"%zi",self.dataArray.count];
  [self requestWelfareactivitylistByoffset:offest successBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    [self.tableView.mj_footer endRefreshing];
    NSArray *arry = responseObject[@"data"][@"list"];
    NSNumber *status = responseObject[@"status"];
    [weakSelf.dataArray addObjectsFromArray:arry];
    [weakSelf.tableView reloadData];
    if (status.integerValue != 1) {
      return ;
    }
    
  } failureBlock:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    if (error != nil) {
      return ;
    }
  }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)requestWelfareactivitylistByoffset:(NSString *)offset
                              successBlock:(void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))successBlock
                              failureBlock:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock{
  
  
//  NSURL *url = [NSURL URLWithString:@"http://hzt.idoool.com/welfareactivitylist"];
//  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//  request.HTTPMethod = @"POST";
//  NSString *httpBody = [NSString stringWithFormat:@"offset=%@&limit=5&type=1",offset];
//  request.HTTPBody = [httpBody dataUsingEncoding:NSUTF8StringEncoding];
//  
//  NSURLSession *session = [NSURLSession sharedSession];
//  // 由于要先对request先行处理,我们通过request初始化task
//   NSLog(@"%@", completionHandler);
//  NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//   
//    dispatch_async(dispatch_get_main_queue(), ^{
//      
//      completionHandler(data,response,error);
//      
//    });
//
//  }];

//
//
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  NSDictionary *parameters = @{@"offset":@"0",@"limit":@"5",@"type":@"1"};
  
  [manager POST:@"http://hzt.idoool.com/welfareactivitylist" parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    
  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
   
    NSLog(@"请求成功 : %@",responseObject);
    
    dispatch_async(dispatch_get_main_queue(), ^{
      
      successBlock(task,responseObject);
      
    });

    
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"Error: %@",error);
    dispatch_async(dispatch_get_main_queue(), ^{
      
      failureBlock(task,error);
      
    });
  }];
  
//  [manager GET:@"http://hzt.idoool.com/welfareactivitylist" parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//    NSLog(@"JSON: %@", responseObject);
//  } failure:^(NSURLSessionTask *operation, NSError *error) {
//    NSLog(@"Error: %@", error);
//  }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  SJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SJTableViewCell" forIndexPath:indexPath];
  
  NSDictionary *dic = self.dataArray[indexPath.row];
  NSString *imageUrl = dic[@"coverImageUrl"];
  [cell.iconView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"image1.ico"]];
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  cell.backgroundColor = [UIColor clearColor];
  
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  return 300;
}


@end
