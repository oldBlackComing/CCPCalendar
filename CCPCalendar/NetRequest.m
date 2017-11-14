//
//  NetRequest.m
//  MeiLiCity
//
//  Created by kwsdzjx on 15/4/27.
//  Copyright (c) 2015年 周佳兴. All rights reserved.
//

#import "NetRequest.h"
//#import "MBProgressHUD.h"
//#import "EducationAdminClient_URL.h"

@implementation NetRequest
static BOOL canCheckNetwork = NO;
+(void)requestUrl:(NSString *)Url andParamas:(id)params andReturnBlock:(void (^)(NSData *, NSError *))cb{
    
    
    if([Url hasPrefix:@"http://182.92.74.232:9994"]){
        NSArray *arr = [Url componentsSeparatedByString:@"182.92.74.232:9994"];
        Url = [NSString stringWithFormat:@"%@%@%@", arr[0], @"182.92.108.162:8124", arr[1]];
    }
    if (![Url hasPrefix:@"https:"]) {
        NSError *error1 = [NSError errorWithDomain:@"请求地址错误" code:405 userInfo:nil];
        
        cb(nil,error1);
        return;
    }
    [[self alloc] requestUrl:Url andParamas:params andReturnBlock:cb];
}
-(void)requestUrl:(NSString *)Url  andParamas:(id)params andReturnBlock:(void (^)(NSData *, NSError *))cb{
    BOOL isFirst = NO;
    
#pragma - mark testShowAllUrl start
    
    NSMutableString *allUrl = [[NSMutableString alloc] init];
    allUrl = [NSMutableString stringWithFormat:@"%@%@",allUrl,Url];
    NSDictionary *my = params;
    NSArray *keyArray = my.allKeys;
    NSArray *valueArray = my.allValues;
    NSString *str = allUrl.lastPathComponent;
    
    if (![str isEqualToString:@"?"]) {
        allUrl = [NSMutableString stringWithFormat:@"%@?",allUrl];
    }
    //    if (![[Url lastPathComponent]isEqualToString:@"?"]) {
    //        Url = [NSString stringWithFormat:@"%@?",Url];
    //    }
    
    NSLog(@"+++++testShowBaseUrl:%@",allUrl);
    for (int i = 0; i<keyArray.count; i++) {
        if (i==keyArray.count-1) {
            allUrl = [NSMutableString stringWithFormat:@"%@%@=%@",allUrl,keyArray[i],valueArray[i]];
        }else{
            allUrl = [NSMutableString stringWithFormat:@"%@%@=%@&",allUrl,keyArray[i],valueArray[i]];
        }
    }
    NSLog(@"+++++++++++++++++++++++++++++++++++++++++++++++testShowAllUrl:%@",allUrl);
#pragma - mark testShowAllUrl end
    
    if(isFirst == NO)
    {
        [[AFNetworkReachabilityManager sharedManager]startMonitoring];
        [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            canCheckNetwork = YES;
            [self requestGoOnUrl:Url andParamas:params andReturnBlock:cb];
        }];
        
    }
    
}




-(void)requestGoOnUrl:(NSString *)Url  andParamas:(id)params andReturnBlock:(void (^)(NSData *, NSError *))cb{
    BOOL isOK = NO;
    BOOL isWifiOK = [[AFNetworkReachabilityManager sharedManager]isReachableViaWiFi];
    //        BOOL is3GOK = [[AFNetworkReachabilityManager sharedManager]isReachableViaWWAN];
    isOK = [[AFNetworkReachabilityManager sharedManager]isReachable];
    if (isOK == FALSE&&canCheckNetwork == YES) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"netState" object:@"NO"];
        
        //***判断是否有网是什么网
        
//        if(![getNetRequest() isEqualToString:@"notReachable"]){
//
//
//            setNetRequest(@"notReachable");
//        }
        
        if (isWifiOK) {
            NSLog(@"wifi");
        }
        
        NSError *error1 = [NSError errorWithDomain:@"请检查网络" code:405 userInfo:nil];
        
        cb(nil,error1);
        //[MBProgressHUD hideHUDForView:alert.superview animated:YES];
    }
    else
    {
//        setNetRequest(@"reachable");
        
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"netState" object:NETSTATE];
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        // 设置超时时间
        
        
        //这里是发送服务端请求的代码
        
        //***在有网的情况下做数据请求
        
        if(!_manager){
            _manager = [[AFHTTPSessionManager alloc]init];




    // this is tioeout
            
            _manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];

            [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
            _manager.requestSerializer.timeoutInterval = 30.f;
            [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];

        }
//        [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [_manager POST:Url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            cb(responseObject, nil);
            //请求结束状态栏隐藏网络活动标志：
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            cb(nil, error);
            //请求结束状态栏隐藏网络活动标志：
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            
        }];
        
        
        
        
    }
}

+(void)postPictures:(NSData *)pic Url:(NSString *)url andFieldName:(NSString *)fieldName andReturnBlock:(void (^)(NSData *, NSError *))cb andFloatProsess:(void (^)(CGFloat))prosess{
    [[self alloc]postPictures:pic Url:(NSString *)url andFieldName:fieldName andReturnBlock:cb andFloatProsess:prosess];
}
-(void)postPictures:(NSData *)pic Url:(NSString *)url andFieldName:(NSString *)fieldName andReturnBlock:(void (^)(NSData *, NSError *))cb andFloatProsess:(void (^)(CGFloat))prosess{
    BOOL isFirst = NO;
    if(isFirst == NO)
    {
        [[AFNetworkReachabilityManager sharedManager]startMonitoring];
        [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            canCheckNetwork = YES;
            [self postGoOnPictures:pic Url:(NSString *)url andFieldName:fieldName andReturnBlock:cb andFloatProsess:prosess];
        }];
        
    }
    
}

-(void)postGoOnPictures:(NSData *)pic Url:(NSString *)url andFieldName:(NSString *)fieldName andReturnBlock:(void (^)(NSData *, NSError *))cb andFloatProsess:(void (^)(CGFloat))prosess{
    
    //AFHTTPSessionManager *_manager = nil;
    
    if(!fieldName){
        fieldName = @"header";
    }
    BOOL isOK = NO;
    BOOL isWifiOK = [[AFNetworkReachabilityManager sharedManager]isReachableViaWiFi];
    //        BOOL is3GOK = [[AFNetworkReachabilityManager sharedManager]isReachableViaWWAN];
    isOK = [[AFNetworkReachabilityManager sharedManager]isReachable];
    if (isOK == FALSE&&canCheckNetwork == YES) {
        //***判断是否有网是什么网
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"没有网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        if (isWifiOK) {
            NSLog(@"wifi");
        }
        NSError *error1 = [NSError errorWithDomain:@"mei链接" code:405 userInfo:nil];
        cb(nil, error1);
        //[MBProgressHUD hideHUDForView:alert.superview animated:YES];
    }
    else
    {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        // 设置超时时间
        if(!_manager){
            _manager = [[AFHTTPSessionManager alloc]init];
            
            
            _manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
        
        _manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
            // 设置超时时间
            [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
            _manager.requestSerializer.timeoutInterval = 10.f;
            [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        }
        [_manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            NSData *data = pic;
            if(![fieldName hasSuffix:@".mp3"]){
                [formData appendPartWithFileData:data name:@"header_img" fileName:[NSString stringWithFormat:@"%@.png",fieldName] mimeType:@"image/png"];
            }else{
              [formData appendPartWithFileData:data name:@"header_img" fileName:[NSString stringWithFormat:@"%@",fieldName] mimeType:@"image/png"];
            }
            
            
            //[formData appendPartWithFileData:data name:@"header_img" fileName:@"heafer.png" mimeType:@"image/png"];
        } success:^(NSURLSessionDataTask *task, id responseObject) {
            cb(responseObject, nil);
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            cb(nil, error);
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            
        }];
        //上传进度
        [_manager setTaskDidSendBodyDataBlock:^(NSURLSession *session, NSURLSessionTask *task, int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
            
            //cb(nil, nil, 1.00);
            prosess(totalBytesSent*1.0/totalBytesExpectedToSend);
        }];
        
    }
}

//     UIWindow * window = [[[UIApplication sharedApplication] windows] firstObject];  ------- 获取最前的视图 -------
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//
//}
@end


