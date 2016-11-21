//
//  AlreadyissueTableViewController.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/22.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//
#import "alreadyissueDetailCollectionViewController.h"
#import "AlreadyissueTableViewController.h"
#import "LeanCloudTool.h"
#import <AVOSCloud/AVOSCloud.h>
#import "DiyMenuModel.h"
#import "UserInfoModel.h"
#import "saveTableViewCell.h"
@interface AlreadyissueTableViewController ()
@property NSMutableArray *temp;
@property NSMutableArray* mydiymenu;
@end

@implementation AlreadyissueTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self getdata];
  self.title = @"已发布的菜谱";

    // 刷新控件
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull To Refresh"];
    self.refreshControl.tintColor = [UIColor greenColor];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
   [self.tableView addSubview:self.refreshControl];
    
    UILongPressGestureRecognizer* longpress = [[UILongPressGestureRecognizer alloc]init];
    [longpress addTarget:self action:@selector(longpress:)];
    

    longpress.delegate=self;
    longpress.minimumPressDuration = 1.0;
   
    [self.tableView addGestureRecognizer:longpress];
}
-(void)getdata{

    
    LeanCloudTool* tool = [LeanCloudTool sharedNetworkMng];
    [tool MyDiyMenuWithParamenters:nil forView:self.view Result:^(NSMutableArray *DiyMenuInfoList) {
        _mydiymenu = DiyMenuInfoList;
        [self.tableView reloadData];
    }];

    
}


-(void)longpress:(UILongPressGestureRecognizer*)gestureRecognizer
{
   
    if(gestureRecognizer.state == UIGestureRecognizerStateEnded){
       
        if(self.tableView.editing == false)
        {
          
            [self.tableView setEditing:YES];
        }
        else{
            
            [self.tableView setEditing:NO];
        }
    }
}



// 下拉刷新方法
- (void)refresh {
    
    if (self.refreshControl.refreshing) {
        
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Loading..."];
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            sleep(1);
            [self.refreshControl endRefreshing];
            self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull To Refresh"];
            
                [self getdata];
             
 
        });
    });
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(_mydiymenu!=nil){
        return _mydiymenu.count;}
    else return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    saveTableViewCell *cell = [saveTableViewCell cellWithTableView:tableView];
    DiyMenuModel* model = _mydiymenu[indexPath.row];
    cell.title.text = [NSString stringWithFormat:@"%@",model.menuName];
    cell.subtitle.text = [NSString stringWithFormat:@"%@",model.experience];
    AVFile *t = model.stepimg[0];
    [t getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if(data != nil){
            UIImage *image = [UIImage imageWithData:data];
            cell.imageview.image = image;}
        else{
            NSLog(@"为什么会错误%@",error);
        }
        
    }];
    
    return cell;
    
 
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    alreadyissueDetailCollectionViewController* detail = [[alreadyissueDetailCollectionViewController alloc]init];
    detail.DiyModel = _mydiymenu[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0;
    
}
//要求委托方的编辑风格在表视图的一个特定的位置。
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    return UITableViewCellEditingStyleDelete;
}
//第三个参数：操作cell对应的位置

-(void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath

{
  
    
    //如果是删除
    
    if(editingStyle==UITableViewCellEditingStyleDelete)
        
    {
        if (indexPath.row<_mydiymenu.count) {
            DiyMenuModel *model = _mydiymenu[indexPath.row];
            NSString *id = model.menuId;
        
            
            AVObject *todo =[AVObject objectWithClassName:@"DiyMenuList" objectId:id];
            
            [todo deleteInBackground];
 
            

        
         
            
            
        }
        
    }
    
}
@end
