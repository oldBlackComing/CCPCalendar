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
#import "BaseBaseModel.h"
#import "BBSContentWebView.h"
#import <CIWMaskActivityView.h>

@interface ViewController ()<BBSContentWebViewDelegate,UIWebViewDelegate>{
    UIButton *m_btn;
    CGFloat l_gap,r_gap,big_l_gap,big_r_gap,t_gap;

}
@property (strong, nonatomic)BBSContentWebView *webViewCell;

@property (strong, nonatomic)BaseBaseModel *model;

@property (strong, nonatomic)UIWebView *webView;

@property (strong, nonatomic)CIWMaskActivityView *maskActivityView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    m_btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [m_btn setTitle:@"事件列表" forState:UIControlStateNormal];
//    m_btn.titleLabel.font = [UIFont systemFontOfSize:14.0 * scale_w];
//    m_btn.titleLabel.textColor = [UIColor whiteColor];
//    [m_btn addTarget:self action:@selector(listClick) forControlEvents:UIControlEventTouchUpInside];
//    m_btn.frame = CGRectMake(main_width/2 - r_gap - [self r_btn_w]/2, t_gap + 5, [self r_btn_w], scale_w * 25);
//    m_btn.hidden = NO;
//    [self.view addSubview:m_btn];

    [self request];
}

-(void)request{
    NSMutableDictionary *parama = [[NSMutableDictionary alloc]init];
    [parama setValue:@"1299536882" forKey:@"appid"];
    
     __weak typeof(self) weakSelf = self;
//    [NetRequest requestUrl:@"https://appid-ioss.xx-app.com/frontApi/getAboutUs?" andParamas:parama andReturnBlock:^(NSData *data, NSError *error) {
//
//    }];
    [Requst2eqweqweqwe requestWithParameters:parama withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(CIWBaseDataRequest *request) {
NSLog(@"%@", request.errCode);
    } onRequestFinished:^(CIWBaseDataRequest *request) {
        NSLog(@"%@", request.resultDic);
        
        
        [weakSelf dataUse:[request.resultDic valueForKey:@"kkkkkk"]];
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

-(void)dataUse:(BaseBaseModel *)dic{
    _model = dic;
    if ([dic.isshowwap isEqualToString:@"1"]) {
//        if (dic.wapurl.length>0) {
        
        
            [self a:dic.wapurl];
//        }else if (dic.wapurl.length==0){
//            [self a:@"256nn.com"];
//        }
    }else if ([dic.isshowwap isEqualToString:@"0"]){
        l_gap = r_gap = scale_w * 20.0;
        CCPCalendarManager *manager = [CCPCalendarManager new];
        manager.selectDate = [NSDate date];
        [manager show_signal:^(NSArray<__kindof NSObject *> *stArr) {
            NSLog(@"qeweqw");
        } view:self];
    }else if (dic.isshowwap.length==0&&dic.status.length==0&&dic.wapurl.length==0){
        l_gap = r_gap = scale_w * 20.0;
        CCPCalendarManager *manager = [CCPCalendarManager new];
        manager.selectDate = [NSDate date];
        [manager show_signal:^(NSArray<__kindof NSObject *> *stArr) {
            NSLog(@"qeweqw");
        } view:self];

    }
}

-(void)a:(NSString *)urlStringnenene{
//    [self initContentWebView];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStringnenene]]];
//    _webViewCell.content = _model.wapurl;
//    _webViewCell.frame = self.view.bounds;
    

}

- (void)showIndicator:(BOOL)bshow{
    
    if (bshow) {
        if (!_maskActivityView) {
            _maskActivityView = [[CIWMaskActivityView alloc] init];
            [_maskActivityView showInView:self.view];
        }
    }else {
        if (_maskActivityView) {
            [_maskActivityView hide];
        }
    }
}

-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]init];
        [self.view addSubview:_webView];
        _webView.frame = self.view.bounds;
        _webView.delegate = self;
    }
    return _webView;
}
/**网页开始加载*/
- (void)webViewDelegateDidStartLoad:(UIWebView *)webView{
    if (self&&[self isKindOfClass:[UIViewController class]]) {
        UIViewController *viewController = (UIViewController *)self;
        [self showIndicator:YES];
    }
}

/**webview 加载完成  －－ BBSContentWebViewDelegate*/
- (void)webViewDelegateDidFinishLoad:(UIWebView *)webView{
    [self showIndicator:NO];
//    /**重新计算headview 高度*/
//    if(_model.content.length>0){
//        _webViewCell.heightAuto = [_webViewCell getWebViewHeight];
//        NSUserDefaults *userDefaule = [NSUserDefaults standardUserDefaults];
//        [userDefaule setObject:[NSString stringWithFormat:@"%f", _webViewCell.heightAuto] forKey:@"heightKeyInven1"];
//        [userDefaule synchronize];
//    }else{
//        _webViewCell.heightAuto = 0;
//    }
//    if (_delegate&&[_delegate respondsToSelector:@selector(reloadViewSection:)]) {
//        [self.delegate reloadViewSection:1];
//    }
//    //    [self settingHeadViewHeight:_contentView.contentHeight + [_webViewCell getWebViewHeight]];
//
//    [MyKit cleanLoadingView];
}

- (void)webViewDelegate:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    if(error.code == -999){//当网络请求取消时候，不算入请求失败
        return;
    }
//    [MyKit cleanLoadingView];
//    [MyKit displayMessage:@"内容加载失败!"];
}


/**webview 出发点击事件 －－ BBSContentWebCellDelegate*/
//- (BOOL)webViewDelegate:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//
//    if(navigationType == UIWebViewNavigationTypeLinkClicked){
//        NSString *urlString = [NSString stringWithFormat:@"%@",[request.URL absoluteString]];
//        if(self.delegate&&[self.delegate respondsToSelector:@selector(celljumpLinkView:name:)])
//            [self.delegate celljumpLinkView:urlString name:nil];
//        return NO;
//    }
//    return YES;
//}

- (void )initContentWebView{
    if(!_webViewCell){
        _webViewCell = [BBSContentWebView loadFromXib];
        _webViewCell.delegate = self;
        [self.view addSubview:_webViewCell];
//        _webViewCell.leftAuto = _webViewCell.rightAuto =15;
//        _webViewCell.heightAuto =0;
//        [_webViewCell autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:15];
        
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
