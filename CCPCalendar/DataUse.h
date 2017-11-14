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

#endif /* DataUse_h */
