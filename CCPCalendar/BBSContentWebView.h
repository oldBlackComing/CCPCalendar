//
//  BBSContentWebCell.h
//  HunBaSha
//
//  Created by GarrettGao on 16/7/1.
//  Copyright © 2016年 hunbohui. All rights reserved.
//

#import "CIWXibView.h"


@protocol BBSContentWebViewDelegate <NSObject>

@optional

/**webview开始加载*/
- (void)webViewDelegateDidStartLoad:(UIWebView *)webView;

/**加载完成*/
- (void)webViewDelegateDidFinishLoad:(UIWebView *)webView;

/**加载失败*/
- (void)webViewDelegate:(UIWebView *)webView didFailLoadWithError:(NSError *)error;


/**点击事件触发*/
- (BOOL)webViewDelegate:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;


@end

@interface BBSContentWebView : CIWXibView

@property (nonatomic, strong)  NSString *content;
@property (nonatomic, weak)  id<BBSContentWebViewDelegate> delegate;
@property (assign, nonatomic) CGFloat webViewHeight;

- (CGFloat)getWebViewHeight;

@end
