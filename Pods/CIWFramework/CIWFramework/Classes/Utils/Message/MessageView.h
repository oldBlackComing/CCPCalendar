//
//  MessageView.h


#import <UIKit/UIKit.h>
#import "PoppingBaseView.h"
@interface MessageView : PoppingBaseView

+ (MessageView *)displayMessage:(NSString *)message;
+ (MessageView *)displayMessage:(NSString *)message withView:(UIView *)disPlayView;
+ (MessageView *)displayMessage:(NSString *)message
                       withView:(UIView *)disPlayView
                 withAgterDelay:(NSTimeInterval)delay;

@end
