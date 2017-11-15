//
//  BBSContentWebCell.m
//  HunBaSha
//
//  Created by GarrettGao on 16/7/1.
//  Copyright © 2016年 hunbohui. All rights reserved.
//

#import "BBSContentWebView.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width //     屏幕宽度



@interface BBSContentWebView()<UIWebViewDelegate,UIGestureRecognizerDelegate>
{
    
    __weak IBOutlet UIWebView *_webView;
    
    __weak IBOutlet NSLayoutConstraint *_webViewWidth;

}

@property (nonatomic, strong) NSMutableArray *imageUrls;

@end

@implementation BBSContentWebView

- (void)dealloc{
    _delegate = nil;
    _imageUrls = nil;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    _webView.scrollView.scrollEnabled = NO;
    [self setWidth:kScreenWidth-30 view:_webView];
    [self addTapOnWebView];
}

- (void)setWidth:(CGFloat)width view:(UIView *)view{
    CGRect frame = self.frame;
    frame.size.width = width;
    view.frame = frame;
}
/**添加图片点击事件*/
-(void)addTapOnWebView
{
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap:)];
    [_webView addGestureRecognizer:singleTap];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

/**点击webview 任何位置触发*/
-(void)imageViewTap:(UITapGestureRecognizer *)sender
{
    CGPoint pt = [sender locationInView:_webView];
    //获取点击图片 src
    NSString *imgURLjs = [NSString stringWithFormat:
                          @"document.elementFromPoint(%f, %f).src",
                          pt.x, pt.y];
    
    //获取点击位置 href
    NSString *imgHrefURLjs = [NSString stringWithFormat:
                              @"document.elementFromPoint(%f, %f).parentElement.href",
                              pt.x, pt.y];
    
    //获取标签名称，判断是否是图片
    NSString *tagJs = [NSString stringWithFormat:
                       @"document.elementFromPoint(%f, %f).tagName",
                       pt.x, pt.y];//获取点击位置 href

    NSString *urlToSave = [_webView stringByEvaluatingJavaScriptFromString:imgURLjs];
    NSString *tag = [_webView stringByEvaluatingJavaScriptFromString:tagJs];
    NSString *href = [_webView stringByEvaluatingJavaScriptFromString:imgHrefURLjs];
    
    
    if(href && [href isKindOfClass:[NSString class]] && href.length){
        //如果图片有链接，直接跳转到链接，不做处理
    }else if(urlToSave && [urlToSave isKindOfClass:[NSString class]] &&
       [[tag uppercaseString] isEqualToString:@"IMG"]){
        //如果点击的图片没有跳转链接，直接打开图片
        [self showImageViewWith:urlToSave];
    }
}

- (void)setContent:(NSString *)content{
    
    _content = content;
    if(content){
        if ([content containsString:@"http"]) {
            NSURL* url = [NSURL URLWithString:content];//创建URL
            NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
            [_webView loadRequest:request];//加载
        }else if (![content containsString:@"http"]){
            //Temp目录下的js文件在根路径，因此需要在加载HTMLString时指定根路径
            NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
            [_webView loadHTMLString:content baseURL:baseURL];
        }
    }
}

/**获取 处理后的webview页面代码*/
- (NSString *)getbbsHtmlWithOriginHtml:(NSString *)htmlString{
    
    if(!htmlString || ![htmlString isKindOfClass:[NSString class]]){
        htmlString = [NSString stringWithFormat:@""];
    }
    NSString *tempPath = [[NSBundle mainBundle]pathForResource:@"temp" ofType:@"html"];
    NSString *tempHtml = [NSString stringWithContentsOfFile:tempPath encoding:NSUTF8StringEncoding error:nil];
    //替换temp内的占位符{{Content_holder}}为需要加载的HTML代码
    tempHtml = [tempHtml stringByReplacingOccurrencesOfString:@"{{Content_holder}}" withString:htmlString];
    return tempHtml;
}

/**开始加载*/
- (void)webViewDidStartLoad:(UIWebView *)webView{
    if(self.delegate && [self.delegate respondsToSelector:@selector(webViewDelegateDidStartLoad:)]){
        [_delegate webViewDelegateDidStartLoad:webView];
    }
}

/**加载完成*/
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //获取webview的高度
    _webViewHeight = [self getContentHeight];
    
    //获取所有图片url
    [self getWebViewImageUrls];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(webViewDelegateDidFinishLoad:)]){
        [_delegate webViewDelegateDidFinishLoad:webView];
    }

}

/**获取webview内容的高度*/
- (CGFloat)getContentHeight{
//    NSString *height_str= [_webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
//    CGFloat height = [height_str floatValue];
    return [UIScreen mainScreen].bounds.size.height;
}

/**获取web中的所有的图片*/
- (void)getWebViewImageUrls{
    static  NSString * const jsGetImages =
    @"function getImages(){\
        var objs = document.getElementsByTagName(\"img\");\
        var imgScr = '';\
    for(var i=0;i<objs.length;i++){\
        imgScr = imgScr + objs[i].src + '+';\
    };\
        return imgScr;\
    };";
    [_webView stringByEvaluatingJavaScriptFromString:jsGetImages];//注入js方法
    NSString *urlResurlt = [_webView stringByEvaluatingJavaScriptFromString:@"getImages()"];
    self.imageUrls = [NSMutableArray arrayWithArray:[urlResurlt componentsSeparatedByString:@"+"]];
    if (_imageUrls.count >= 2) {
        [_imageUrls removeLastObject];
    }
}

/**打开图片*/
- (void)showImageViewWith:(NSString *)imageUrl{
    
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    BOOL is = NO;
    if(self.delegate && [self.delegate respondsToSelector:@selector(webViewDelegate:shouldStartLoadWithRequest:navigationType:)]){
        is = [_delegate webViewDelegate:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    return is;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"webView 加载失败:%@",error);
    if(self.delegate && [self.delegate respondsToSelector:@selector(webViewDelegate:didFailLoadWithError:)]){
        [_delegate webViewDelegate:webView didFailLoadWithError:error];
    }
}

- (CGFloat)getWebViewHeight{
    return _webViewHeight + 20;
}
@end
