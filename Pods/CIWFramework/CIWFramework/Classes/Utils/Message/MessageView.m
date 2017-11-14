//
//  MessageView.m


#import "MessageView.h"
#import "PureLayout.h"

@interface MessageView()
@property (nonatomic, strong) UILabel *messageLabel;
@end

@implementation MessageView

-(void)dealloc{
    _messageLabel = nil;
}

- (id)init{
    self = [super init];
    if(self){
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 0.8;
        self.backgroundColor = [UIColor colorWithRed:255/255.0 green:82/255.0 blue:122/255.0 alpha:0.9];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 8;
        
        UILabel *label = [[UILabel alloc] initForAutoLayout];
        [self addSubview:label];
        [label autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        [label autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
        [label autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
        [label autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:15];
        [label autoSetDimension:ALDimensionHeight toSize:20 relation:NSLayoutRelationGreaterThanOrEqual];
        [label autoSetDimension:ALDimensionWidth toSize:230 relation:NSLayoutRelationLessThanOrEqual];
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 5;
        label.textColor = [UIColor whiteColor];
        self.messageLabel = label;
    }
    return self;
}


- (void)hideView{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished){
        if (finished) {
            [self removeFromSuperview]; 
        }
    }];
}

+ (MessageView *)displayMessage:(NSString *)message{
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    return [self displayMessage:message withView:window];
}


+ (MessageView *)displayMessage:(NSString *)message withView:(UIView *)disPlayView{
    return [MessageView displayMessage:message withView:disPlayView withAgterDelay:1];
}

+ (MessageView *)displayMessage:(NSString *)message
                       withView:(UIView *)disPlayView
                 withAgterDelay:(NSTimeInterval)delay
{
    
    MessageView *view = [[MessageView alloc] init];
    view.messageLabel.text = message;
    [self cleanOldViewWithSuperView:disPlayView];
    if(disPlayView){
        [view showWithView:disPlayView];
    }else{
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        [view showWithView:window];
    }
    [view autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [view autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
    [view performSelector:@selector(hideView) withObject:nil afterDelay:delay];
    return view;
}

+ (void)cleanOldViewWithSuperView:(UIView *)superView
{
    for (id view in superView.subviews) {
        if([view isKindOfClass:[MessageView class]]){
            [view removeFromSuperview];
        }
    }
}

@end
