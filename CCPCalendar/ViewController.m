//
//  ViewController.m
//  CCPCalendar
//
//  Created by Ceair on 17/5/25.
//  Copyright © 2017年 ccp. All rights reserved.
//

#import "ViewController.h"
#import "CCPCalendarManager.h"
#import "ListViewController.h"
#import "Requst2eqweqweqwe.h"
#import "NetRequest.h"

@interface ViewController (){
    UIButton *m_btn;
    CGFloat l_gap,r_gap,big_l_gap,big_r_gap,t_gap;

}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    l_gap = r_gap = scale_w * 20.0;
    CCPCalendarManager *manager = [CCPCalendarManager new];
    manager.selectDate = [NSDate date];
    [manager show_signal:^(NSArray<__kindof NSObject *> *stArr) {
        NSLog(@"qeweqw");
    } view:self];
    
    m_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [m_btn setTitle:@"事件列表" forState:UIControlStateNormal];
    m_btn.titleLabel.font = [UIFont systemFontOfSize:14.0 * scale_w];
    m_btn.titleLabel.textColor = [UIColor whiteColor];
    [m_btn addTarget:self action:@selector(listClick) forControlEvents:UIControlEventTouchUpInside];
    m_btn.frame = CGRectMake(main_width/2 - r_gap - [self r_btn_w]/2, t_gap + 5, [self r_btn_w], scale_w * 25);
    m_btn.hidden = NO;
    [self.view addSubview:m_btn];

    [self request];
}

-(void)request{
    NSMutableDictionary *parama = [[NSMutableDictionary alloc]init];
    [parama setValue:@"" forKey:@"appid"];
    
//    [NetRequest requestUrl:@"https://appid-ioss.xx-app.com/frontApi/getAboutUs?" andParamas:parama andReturnBlock:^(NSData *data, NSError *error) {
//
//    }];
    [Requst2eqweqweqwe requestWithParameters:parama withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(CIWBaseDataRequest *request) {
NSLog(@"%@", request.errCode);
    } onRequestFinished:^(CIWBaseDataRequest *request) {
        NSLog(@"%@", request.resultDic);
    } onRequestCanceled:^(CIWBaseDataRequest *request) {
NSLog(@"%@", request.errCode);
    } onRequestFailed:^(CIWBaseDataRequest *request) {

    }];
}
- (CGFloat)r_btn_w {
    NSString *tt = m_btn.titleLabel.text;
    CGRect rect = [tt boundingRectWithSize:CGSizeMake(1000, 25 * scale_w) options:NSStringDrawingUsesFontLeading attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:14 * scale_w]} context:nil];
    return rect.size.width;
}

-(void)dataUse:(NSDictionary *)dic{
    if ([dic valueForKey:@"isshowwap"]) {
        
    }
}
- (IBAction)test:(id)sender {
//    [CCPCalendarManager show_mutil:^(NSArray *stArr) {
//        [stArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSLog(@"obj.ccpDate---%@",[obj valueForKey:@"ccpDate"]);
//            NSLog(@"obj.week---%@",[obj valueForKey:@"week"]);
//        }];
//    }];
    CCPCalendarManager *manager = [CCPCalendarManager new];
    manager.selectDate = [NSDate date];
    [manager show_signal:^(NSArray<__kindof NSObject *> *stArr) {
        
    }];
//    [CCPCalendarManager show_signal_past:^(NSArray *stArr) {
//        
//    }];
}

-(void)listClick{
    ListViewController *liVC = [[ListViewController alloc]init];
  [self.navigationController pushViewController:liVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
