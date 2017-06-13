//
//  HLTableViewController.m
//  Pro18
//
//  Created by 盛嘉 on 2017/5/17.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "HLTableViewController.h"
#import "PostsTableViewCell.h"
#import "BannerView.h"
#import "MenuView.h"
#import "Masonry.h"
#import "SjCollectionViewController.h"





@interface HLTableViewController () <UITabBarDelegate,UITableViewDataSource>
@property(strong , nonatomic) SjCollectionViewController *svc;
@end

@implementation HLTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"PostsTableViewCell" bundle:nil] forCellReuseIdentifier:@"PostsTableViewCell"];
    self.svc = [[SjCollectionViewController alloc]initWithNibName:@"SjCollectionViewController" bundle:nil];
    
    __weak HLTableViewController *weakSelf = self;
//    [self.svc.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
//    }];
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 350);
    BannerView *bannerView = [[NSBundle mainBundle]loadNibNamed:@"BannerView" owner:self options:nil].lastObject;
    MenuView *menuView = [[NSBundle mainBundle]loadNibNamed:@"MenuView" owner:self options:nil].lastObject;
    [view addSubview:bannerView];
    [view addSubview:menuView];
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).with.offset(0);
        make.left.equalTo(view).with.offset(0);
        make.right.equalTo(view).with.offset(0);
        make.height.mas_equalTo(@200);
    }];
    [menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bannerView.mas_bottom).with.offset(0);
        make.right.equalTo(view).with.offset(0);
        make.left.equalTo(view).with.offset(0);
        make.height.mas_equalTo(@150);
    }];
      
    self.tableView.tableHeaderView = view;
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = [UIColor blueColor];
    scrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
    scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*3, 200);
    scrollView.pagingEnabled = YES;
  
    
    [view addSubview: scrollView];
  //  UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.width*3, 30)];
  UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 170, 100, 100)];
  pageControl.tintColor = [UIColor redColor];
    pageControl.numberOfPages = 3;
    pageControl.tag = 101;
    [scrollView addSubview:pageControl];
    float _x = 0;
    for (int index = 0; index <4; index ++) {
        _imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0 + _x, 0, [UIScreen mainScreen].bounds.size.width - 20, 200)];
        NSString *imageName = [NSString stringWithFormat:@"image%d.ico" , index +1];
        _imageView.image = [UIImage imageNamed:imageName];
        [scrollView addSubview:_imageView];
        _x +=[UIScreen mainScreen].bounds.size.width;
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -ScrollView

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int currunt = scrollView.contentOffset.x /[UIScreen mainScreen].bounds.size.width;
    UIPageControl *pageControl = (UIPageControl *)[scrollView viewWithTag:101];
    pageControl.currentPage = currunt;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }else{
        return 10;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostsTableViewCell" forIndexPath:indexPath];
    
 
    
    return cell;
}

- (nullable NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"推荐";
    }else{
        return @"最近帖子";
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120.0;
}


    

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
