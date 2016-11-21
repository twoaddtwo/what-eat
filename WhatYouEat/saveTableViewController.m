//
//  saveTableViewController.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/22.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//


#import "saveTableViewCell.h"
#import "saveTableViewController.h"
#import "NetworkingTool.h"
#import "saveDetailTableViewController.h"
@interface saveTableViewController ()
@property NSMutableArray* savearray;
@property NSMutableArray* saveArray;
@property DetailMakeModel* model;
@end
@implementation saveTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    UILongPressGestureRecognizer* longpress = [[UILongPressGestureRecognizer alloc]init];
    [longpress addTarget:self action:@selector(longpress:)];
    
    
    longpress.delegate=self;
    longpress.minimumPressDuration = 1.0;
    
    [self.tableView addGestureRecognizer:longpress];
    // 刷新控件
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull To Refresh"];
    self.refreshControl.tintColor = [UIColor greenColor];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    //[self.tableView addSubview:self.refreshControl];
    
   
    [self getdata];
   
    
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

-(void) buttonAction: (UISegmentedControl *) sender
{
    //得到按钮点击索引
    NSInteger index = sender.selectedSegmentIndex;
    
   
    if(index == 1){
      
    }
 
    
}
-(void)getdata{
    _savearray = [NSMutableArray array];
    _saveArray = [NSMutableArray array];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    
    NSString *filename=[plistPath stringByAppendingPathComponent:@"SAVE.plist"];
    
    
    
    NSArray* array = [NSArray arrayWithContentsOfFile:filename];
    _savearray = [NSMutableArray arrayWithArray:array];

    
    
    for(int i=0;i<_savearray.count;i++){
   
        
        NSDictionary* parameters = @{@"id":_savearray[i]};
        NetworkingTool* tool = [NetworkingTool sharedNetworkMng];
        [tool MenuMakeRequestWithParamenters:parameters forView:self.tableView Result:^(DetailMakeModel *menumake) {
            
            [_saveArray addObject:menumake];
            [self.tableView reloadData];
        
        }];
    }
    
 
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
         [self.tableView setEditing:NO];
    
        });
    });
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return _saveArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    saveTableViewCell* cell = [saveTableViewCell cellWithTableView:tableView];


    _model = _saveArray[indexPath.row];
    cell.title.text = [NSString stringWithFormat:@"%@",_model.Name];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://tnfs.tngou.net/image%@",_model.ImageUrl]];
    cell.imageview.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
   
        return cell;
        
        
        
        
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    saveDetailTableViewController* detail = [[saveDetailTableViewController alloc]init];
     
    detail.model = _saveArray[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
    }

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
    
}
//要求委托方的编辑风格在表视图的一个特定的位置。
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCellEditingStyle result = UITableViewCellEditingStyleDelete;
    
    return result;
}
//第三个参数：操作cell对应的位置

-(void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath

{
    
    //如果是删除
    
    if(editingStyle==UITableViewCellEditingStyleDelete)
        
    {
        if (indexPath.row<_saveArray.count) {
            
            [_savearray removeObjectAtIndex:indexPath.row];//移除数据源的数据
            [_saveArray removeObjectAtIndex:indexPath.row];
            
            
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
            NSString *plistPath = [paths objectAtIndex:0];
            
            
            
            NSString *filename=[plistPath stringByAppendingPathComponent:@"SAVE.plist"];
            
            [_savearray writeToFile:filename atomically:YES];
            
     [self.tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
            
            
        }
        
    }
      [self.tableView setEditing:NO];
}






@end
