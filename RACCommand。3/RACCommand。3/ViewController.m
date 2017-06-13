//
//  ViewController.m
//  RACCommand。3
//
//  Created by 盛嘉 on 2017/6/1.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "ViewController.h"
#import "SJView.h"
#import "ReactiveCocoa.h"
 
@interface ViewController ()
@property (assign , nonatomic) int age;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation ViewController
//+ (instancetype)allocWithZone:(struct _NSZone *)zone{
//  ViewController *vc = [super allocWithZone:zone];
//  
//  //viewDidLoad
//  [[vc rac_signalForSelector:@selector(viewDidLoad)]subscribeNext:^(id x) {
//    
//  }];
//  
//  //ViewWillAppear
//  [[vc rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
//    
//  }];
//  return vc;
//}
/*
- (void)viewDidLoad{
  //RAC监听
//   [[_button rac_signalForControlEvents:UIControlEventTouchDown]subscribeNext:^(__kindof UIControl * _Nullable x) {
//     NSLog(@"点击了");
//   }];
//  [[[NSNotificationCenter defaultCenter]rac_addObserverForName:@"Note" object:nil] subscribeNext:^(NSNotification * x) {
//    NSLog(@"监听到通知%@",x);
//    
//  }];
//  [[NSNotificationCenter defaultCenter] postNotificationName:@"Note" object:nil];
  [_textField.rac_textSignal subscribeNext:^(id x) {
    NSLog(@"%@",x);
  }];
  //绑定
  RAC(_label,text) = _textField.rac_textSignal;
}
*/
- (void)viewDidLoad{
  //创建最热数据信号
  RACSignal *hotSignal =  [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    [subscriber sendNext:@"最热数据"];
    return nil;
  }];
  //创建最新数据信号
 RACSignal *newSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    [subscriber sendNext:@"最新数据"];
    return nil;
  }];
  //rac_liftSelector有几个信号就有几个参数
  [self rac_liftSelector:@selector(updateUIWithHot:new:) withSignalsFromArray:@[hotSignal,newSignal]];
}

- (void)updateUIWithHot:(NSString *)hot new:(NSString *)new{
  NSLog(@"%@ %@",hot,new);
}



//- (void)viewDidLoad {
//  [super viewDidLoad];
////  SJView *v = [[SJView alloc]init];
////  v.backgroundColor = [UIColor redColor];
////  v.frame = CGRectMake(50, 50, 100, 100);
////  [self.view addSubview:v];
////  [[v rac_signalForSelector:@selector(touchesBegan:withEvent:)] subscribeNext:^(id x) {
////    NSLog(@"点击view");
////  }];
////  
////  [[self rac_valuesForKeyPath:@keypath(self,age) observer:self]subscribeNext:^(id x) {
////    NSLog(@"%@",x);
////  }];
//   [RACObserve(self, age) subscribeNext:^(id x) {
//     NSLog(@"%@",x);
//   }];
//}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  self.age++;
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
