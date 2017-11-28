//
//  DataUse.h
//  CCPCalendar
//
//  Created by hbh112 on 2017/11/9.
//  Copyright © 2017年 ccp. All rights reserved.
//

#ifndef DataUse_h
#define DataUse_h



static inline NSString * myselfSaveFile(NSString *userNum, NSString *paramaString,NSString *fileName) {
    
    NSString *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)[0];
    
    
    NSString *imageDir = [[paths stringByAppendingPathComponent:userNum]stringByAppendingPathComponent:paramaString];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSLog(@"%@", imageDir);
    
    return imageDir;
}


static inline NSString * dePath1(){
    NSString *path2 = nil;
    NSString *path3;
    path2= myselfSaveFile(@"a", @"lists", @"lists.plist");
    
    path3 = [path2 stringByAppendingPathComponent:[NSString stringWithFormat:@"listForAdd%@%@.plist", @"1", @"1"]];
    return path3;
}

static inline NSArray * arrList(){
    NSArray *saveDic;
    
    NSString * path3 = nil;
    path3 = dePath1();
    
    saveDic = [[NSArray alloc]initWithContentsOfFile:path3];
    if(saveDic){
        return saveDic;
    }else{
        return [NSArray array];
    }
}

static inline BOOL writeTo(NSArray *array){
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
//    if(array){
//        [dic setValue:array forKey:@"array1"];
//    }else{
//        [dic setValue:[NSArray array] forKey:@"array1"];
//    }
    
    
//    BOOL succeed = [array writeToFile:path3 atomically:YES];

    NSString *path3;
    path3= dePath1();
    
    BOOL succeed = [array writeToFile:path3 atomically:YES];
    if (succeed) {
        NSLog(@"-------------- catch ---- 缓存成功");
        return YES;
    }else{
        NSLog(@"%@", @"缓存失败");
        return NO;
    }
}

#endif /* DataUse_h */
