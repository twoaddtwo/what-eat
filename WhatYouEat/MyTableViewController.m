//
//  MyTableViewController.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/16.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import "MyTableViewController.h"
#import "MyTableViewCell.h"
#import "ViewController.h"
#import "UserInfoModel.h"
#import "LeanCloudTool.h"
#import <AVOSCloud/AVOSCloud.h>
#import "AlreadyissueTableViewController.h"
#import "settingViewController.h"
@interface MyTableViewController ()
@property NSArray* array;
@property UserInfoModel* model;
@end

@implementation MyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _array = @[@"退出登录",@"已发布的菜谱"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 1;}
    else
        return _array.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0){
        MyTableViewCell* cell = [MyTableViewCell cellWithTableView:tableView];
        cell.backgroundColor = [UIColor yellowColor];
        
        NSString* parameter = [[NSUserDefaults standardUserDefaults]objectForKey:@"email"];
     LeanCloudTool* tool = [LeanCloudTool sharedNetworkMng];
        [tool UserInfoWithParamenters:parameter forView:self.view Result:^(UserInfoModel *userInfo) {
            _model = userInfo;
            cell.username.text = _model.username;
            AVFile *file = _model.portrait;
            [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                UIImage *image = [UIImage imageWithData:data];
                cell.portrait.image = image;
            }];
            cell.email.text = _model.email;
        }];
        
        return cell;
    }
    
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"exitCell"];
        //没找到就创建
        if (cell == nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"exitCell"];
        }
        
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@",_array[indexPath.row]];
        return cell;

        
        
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 99;}
    else{
        return 50;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1 && indexPath.row == 0){
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"ifLogin"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController *loginview = [story instantiateViewControllerWithIdentifier:@"loginView"];
        [self presentViewController:loginview animated:YES completion:nil];
    }
    if(indexPath.section == 0){
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        settingViewController *setting = [story instantiateViewControllerWithIdentifier:@"settingviewcontroller"];
        setting.model = _model;
        [self.navigationController pushViewController:setting animated:YES];
        
    }if(indexPath.section == 1 && indexPath.row == 1){
        AlreadyissueTableViewController *already = [[AlreadyissueTableViewController alloc]init];
        [self.navigationController pushViewController:already animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 15;
    
}
@end
