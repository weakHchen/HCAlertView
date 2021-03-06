//
//  ViewController.m
//  HCAlertView
//
//  Created by hchen on 2017/10/30.
//  Copyright © 2017年 QZW. All rights reserved.
//

#import "ViewController.h"
#import "HCAlertView.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *aTableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = @[@"1个按钮",@"2个按钮",@"attrMessage",@"系统UIAlertController"];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        [HCAlertView alertWithTitle:@"HCAlertView" message:@"测试测试测试测试测试\n测试测试测试测试测试测试\n测试测试测试测试测试测试测试"
                           textMent:NSTextAlignmentLeft cancel:nil sure:@"我知道了"
                           callBack:^(HCAlertView *alert, NSInteger index) {
                               NSLog(@"%ld", (long)index);
                           }];
    } else if (indexPath.row == 1) {
        [HCAlertView alertWithTitle:@"HCAlertView" message:@"测试测试测试测试测试\n测试测试测试测试测试测试\n测试测试测试测试测试测试测试"
                           textMent:NSTextAlignmentLeft cancel:@"取消" sure:@"确定"
                           callBack:^(HCAlertView *alert, NSInteger index) {
                               NSLog(@"%ld", (long)index);
                           }];
    } else if (indexPath.row == 2) {
        NSString *message = @"我是attrMessage\n测试测试测试测试测试测试\n测试测试测试测试测试测试测试";
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:message];
        [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(message.length-14, 14)];
        [HCAlertView alertWithTitle:@"HCAlertView" attrMsg:attr
                           textMent:NSTextAlignmentCenter cancel:nil sure:@"我知道了"
                           callBack:^(HCAlertView *alert, NSInteger index) {
                               NSLog(@"%ld", (long)index);
                           }];
        
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"标题" message:@"这个是UIAlertController的默认样式" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * myCarListCellID = @"HCAlertView";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCarListCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCarListCellID];
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}

@end
