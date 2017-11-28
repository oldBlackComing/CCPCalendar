//
//  EditViewController.m
//  CCPCalendar
//
//  Created by hbh112 on 2017/11/28.
//  Copyright © 2017年 ccp. All rights reserved.
//

#import "EditViewController.h"
#import "DataUse.h"
#import "BaseBaseModelList.h"
#import "ListViewController.h"

@interface EditViewController ()<UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _titleLabel.text = _titleString;
}

-(void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    _titleLabel.text = _titleString;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)act:(id)sender {
    
    NSMutableArray *mutArr = [[NSMutableArray alloc]initWithArray:arrList()];
    BaseBaseModelList *model = [[BaseBaseModelList alloc]init];
    model.data = _titleString;
    if (_textView.text.length>0) {
        model.string = _textView.text;
    }else{
        model.string = @"You did nothing";
    }
    NSData *data = [model getArchivedData];
    if (mutArr.count>0) {
        [mutArr insertObject:data atIndex:0];
    }else{
        [mutArr addObject:data];
    }
    BOOL a = writeTo(mutArr);
    if (a) {
        ListViewController *liVC = [[ListViewController alloc]init];
        [self presentViewController:liVC animated:YES completion:^{
            
        }];
    }

}
- (IBAction)ba:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)OkC:(id)sender {
    [_textView resignFirstResponder];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) { //点击键盘return键，相当于textFieldShouldReturn方法
                [textView resignFirstResponder]; //取消第一响应者，收回键盘
        return NO; //点击键盘return键后不允许再输入
    }
    return YES; //允许继续输入
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
