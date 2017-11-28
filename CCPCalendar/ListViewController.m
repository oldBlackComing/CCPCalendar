//
//  ListViewController.m
//  CCPCalendar
//
//  Created by hbh112 on 2017/11/9.
//  Copyright © 2017年 ccp. All rights reserved.
//

#import "ListViewController.h"
#import "DataUse.h"
#import "BaseBaseModelList.h"
#import "ListCell.h"

@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSDictionary *saveDic;
    NSArray *dataArr;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    dataArr = arrList();
    [_tableView reloadData];
    [self.tableView registerNib:[UINib nibWithNibName:@"ListCell" bundle:nil] forCellReuseIdentifier:@"ListCell"];
    self.tableView.estimatedRowHeight = 999999;

    
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSData *data = dataArr[indexPath.row];
    BaseBaseModelList *model;
    if (data) {
        model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
    
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.theTitleLabel.text = model.data;
    cell.subTitleLabel.text = model.string;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
