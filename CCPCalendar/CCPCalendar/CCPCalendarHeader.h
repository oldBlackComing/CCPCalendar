//
//  CCPCalendarHeader.h
//  CCPCalendar
//
//  Created by Ceair on 17/5/25.
//  Copyright © 2017年 ccp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCPCalendarManager.h"

@protocol listClickDelegate <NSObject>

-(void)list;

@end
@interface CCPCalendarHeader : UIView

@property (strong, nonatomic)id <listClickDelegate> delegate;

@property (nonatomic, strong) CCPCalendarManager *manager;

- (void)displayLabel;
- (void)initSubviews;
@end
