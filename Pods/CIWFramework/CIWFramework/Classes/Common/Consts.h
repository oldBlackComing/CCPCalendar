//
//  Consts.h
//  HunBoHuiReqeust_demo
//
//  Created by GarrettGao on 14-10-24.
//  Copyright (c) 2014年 HapN. All rights reserved.
//
//  Git Master 分支

#ifndef HunBoHuiReqeust_demo_Consts_h
#define HunBoHuiReqeust_demo_Consts_h

#define KEY_MODEL      @"kModel"
#define kSelf_View_Tag 135024
#define kCacheCityList @"kCacheCityList"
#define kCityChnage     @"kCityChnageNotification"

/**获取appdelegate*/
#define APP_DELEGATE (AppDelegate *)[UIApplication sharedApplication].delegate
/**设置颜色*/
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(1.0)]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RGBRandom(a) [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:(a)]
#define RGBFromHexColor(HexValue) \
[UIColor colorWithRed:((float)((HexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((HexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(HexValue & 0xFF))/255.0 alpha:1.0]

/**等到屏幕宽高*/
#define kScreenWidth [UIScreen mainScreen].bounds.size.width //     屏幕宽度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height //   屏幕高度


//当前系统版本是否 >= 某个版本
#define kiOSVersion(v) ([UIDevice currentDevice].systemVersion.floatValue >= (v))

/**iphone比例*/
#define kSeveralfold  kScreenWidth/320.f
#define kSeveralfold6 kScreenWidth/375.f

/**版本号*/
#define APP_VERSION    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


#define APP_KEY        @"1d78ae9a3e219d6531758daf8c230c1c"
#define APP_ID         @"10011"
#define APP_BUNDLE_ID_INHOUSE   @"com.hunbohui.yingbashaETP"
#define APP_BUNDLE_ID_APPSTORE  @"com.hunbohui.yingbasha"
#define kAppStoreAddress    @"https://itunes.apple.com/us/app/ying-ba-sha-zhong-guo-hun-bo-hui/id1155985315?l=zh&ls=1&mt=8"

//AppID：wxa8555a4cafbab428
//AppSecret： 1c2347619a55ec8bfa6cdb6cc6674d77

/**全局控制 线上 线下 接口，默认线上接口
 * 注意： 开发者如果需要更改接口，请直接在 设置 －》关于结婚订购 页面 两个指头双击5下 直接修改
 *       !请勿修随意修改此处接口!
 **线上接口*/
#define REQUEST_HOST   @"https://api.jiehun.com.cn"         // 默认线上接口
//#define REQUEST_HOST   @"http://api.zhy.hapn.cc"


#define URL_SCHEME @"ybs"
#define URL_SCHEME__ @"ybs://"

#define kDefault_imageName   @"default_img"//默认图片
#define kDefault_imageName_small   @"default_img_small"//默认小图片

#define kDetault_UserName     @"default_user"//默认

//新浪微博AppKey
#define kAppKey_Weibo           @"1632741491"
#define kRedirectURI_Weibo      @"http://www.jiehun.com.cn/api/weibo/_grant"

//QQ AppKey
#define kAppID_QQ               @"1105626771"
#define kAppID_QQ_ETP           @"1105750546"

#define MessageNotificotion  @"MessageNotificotion"
//微信kAuthScope、Secret、AppId、Grant_type
#define kAppId_weChat @"wx78b27fadc81b6df4"
#define kAppSecret_weChat @"022fa45d435d7845179b6ae8d1912690"
#define kAuthScope   @"snsapi_userinfo"
#define kGrant_type  @"authorization_code"


//用于web请求的时候，后台识别用
//#define kUserAgent @"{app-wap-mode:1}"
#define kUserAgent @"a=yingbasha&p=ybs&m=3"

#define weak(obj) __weak typeof(obj) _weak##obj = obj;

#endif

#ifdef DEBUG

#else

#define NSLog(...) {}

#endif


