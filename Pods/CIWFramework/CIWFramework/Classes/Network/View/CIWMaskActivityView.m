//
//  CIWMaskActivityView.m
//

#import "CIWMaskActivityView.h"
#import "PureLayout.h"

#define CIWSrcName(file) [@"CIWBundle.bundle" stringByAppendingPathComponent:file]
#define CIWFrameworkSrcName(file) [@"Frameworks/CIWBundle.CIWBundle.bundle" stringByAppendingPathComponent:file]
@implementation CIWMaskActivityView


- (id)init{
    self = [super init];
    if(self){
        
        UIImageView *bgImageView = [[UIImageView alloc] initForAutoLayout];
        [self addSubview:bgImageView];
        [bgImageView autoPinEdgesToSuperviewEdges];
        bgImageView.backgroundColor = [UIColor blackColor];
        bgImageView.alpha = 0.02;
        
        
        
        _bgMaskView = [[UIView alloc] initForAutoLayout];
        [self addSubview:_bgMaskView];
        [_bgMaskView autoSetDimension:ALDimensionWidth
                               toSize:70
                             relation:NSLayoutRelationEqual];
        [_bgMaskView autoSetDimension:ALDimensionHeight toSize:70];
        [_bgMaskView autoCenterInSuperview];
        //        _bgMaskView.layer.masksToBounds = YES;
        _bgMaskView.layer.cornerRadius = 5;
        
        
        _bgMaskView.backgroundColor = [RGBFromHexColor(0xffe6ec) colorWithAlphaComponent:0.7];
        
        
        
        _loadingAnimaView = [[CIWRequestLoadingView alloc] initForAutoLayout];
        
        //        _loadingAnimaView.backgroundColor = [UIColor redColor];
        
        [_bgMaskView addSubview:_loadingAnimaView];
        
        [_loadingAnimaView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        
        
        _loadingAnimaView.progress = 1;
        
        [_loadingAnimaView startAnimating];
        
        _loadingImage = [[UIImageView alloc] initForAutoLayout];
        [_bgMaskView addSubview:_loadingImage];
        [_loadingImage autoSetDimension:ALDimensionWidth
                                 toSize:23];
        [_loadingImage autoSetDimension:ALDimensionHeight
                                 toSize:20];
        
        //        [_loadingImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10.0];
        //        [_loadingImage autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_loadingImage autoCenterInSuperview];
        //        _loadingImage.contentMode = UIViewContentModeCenter;
        //        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        UIImage *loadingImage = [UIImage imageNamed:CIWSrcName(@"icon_pulldown_refresh.png")] ?: [UIImage imageNamed:CIWFrameworkSrcName(@"icon_pulldown_refresh.png")];
        [_loadingImage setImage:loadingImage];
        
        
        
        
        UILabel *label = [[UILabel alloc] initForAutoLayout];
        [_bgMaskView addSubview:label];
        [label autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:3];
        [label autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:3];
        [label autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:2];
        [label autoSetDimension:ALDimensionWidth toSize:60 relation:NSLayoutRelationGreaterThanOrEqual];
        [label autoSetDimension:ALDimensionWidth toSize:200 relation:NSLayoutRelationLessThanOrEqual];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"";
        label.tag = 1234;
    }
    return self;
}

- (void)showInView:(UIView *)parentView withMessage:(NSString *)strMessage
{
    UILabel *label = (UILabel *)[_bgMaskView viewWithTag:1234];
    label.text = strMessage ? : @"";
    [label sizeToFit];
    
    _bgMaskView.width = (label.width < _bgMaskView.width) ? _bgMaskView.width : (label.width);
    _bgMaskView.height += 5;
    label.top = _bgMaskView.height - label.height-5;
    
    [self showInView:parentView];
}

- (void)showInView:(UIView*)parentView{
    
    
    if(!parentView){
        return;
    }
    
    self.userInteractionEnabled = !self.isTouch;
    [self nextResponder];
    
    UILabel *label = (UILabel *)[_bgMaskView viewWithTag:1234];
    if(label.text.length == 0){
        _titleLabelHeight.constant = 0;
    }
    
    
    self.alpha = 0.1;
    [parentView addSubview:self];
    
    /**默认平铺整个试图，判断到self.view 会空出导航条位置*/
    CGFloat top = 0;
    
    if(parentView.tag == kSelf_View_Tag){
        top = ([UIDevice currentDevice].systemVersion.floatValue) >= 7.0 ? 64.:44.;
    }
    NSDictionary *metricsDic = @{@"top":[NSNumber numberWithFloat:top]
                                 };
    NSDictionary *views = NSDictionaryOfVariableBindings(self);
    [UIView ciw_AddConstraintsWithParameter:metricsDic
                                   viewsDic:views
                            visualFormatArr:@[@"H:|-0-[self]-0-|",
                                              @"V:|-top-[self]-0-|"]
                           addConstraintsTo:parentView];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         //
                     }];
}


- (void)showInView:(UIView*)parentView withIsTouch:(BOOL)isTouch{
    self.isTouch = isTouch;
    [self showInView:parentView];
}


- (void)hide{
    weak(self);
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         
                         [_weakself.loadingAnimaView stopAnimating];
                         
                         [self removeFromSuperview];
                     }];
}
- (void)dealloc {
    _bgMaskView = nil;
    _loadingImage = nil;
    _loadingAnimaView = nil;
    _titleLabelHeight = nil;
}
@end
