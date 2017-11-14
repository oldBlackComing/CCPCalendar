//
//  CIWMaskActivityView.h
//

#import "CIWXibView.h"
#import "CIWRequestLoadingView.h"

@interface CIWMaskActivityView : CIWXibView
@property (strong, nonatomic) UIView *bgMaskView;
@property (strong, nonatomic) UIImageView *loadingImage;
@property (strong, nonatomic) CIWRequestLoadingView *loadingAnimaView;
@property (strong, nonatomic) NSLayoutConstraint *titleLabelHeight;

@property (assign, nonatomic) BOOL isTouch;//加载时，遮挡部分是否可以触发手势事件

- (void)showInView:(UIView *)parentView withMessage:(NSString *)strMessage;
- (void)showInView:(UIView*)parentView;
- (void)showInView:(UIView*)parentView withIsTouch:(BOOL)isTouch;

- (void)hide;
@end
