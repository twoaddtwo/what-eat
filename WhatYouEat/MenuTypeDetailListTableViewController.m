//
//  MenuTypeDetailListTableViewController.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/28.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import "MenuTypeDetailListTableViewController.h"
#import "saveTableViewCell.h"
@interface MenuTypeDetailListTableViewController ()
@property MenuList* menulistarray;
@property NSArray* menutypearray;
@property NSArray* menutypeidarray;
@end

@implementation MenuTypeDetailListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    _menutypeidarray = @[@"1",@"10",@"15",@"52",@"62",@"68",@"75",@"82",@"98",@"112"];
    _menutypearray = @[@"美容",@"减肥",@"保健养生",@"人群",@"时节",@"餐时",@"器官",@"调养",@"肠胃消化",@"孕产哺乳"];
    
  
    NSDictionary* parameters = @{@"id":_menutypeidarray[_idrow]};
    
    NetworkingTool* tool = [NetworkingTool sharedNetworkMng];
    [tool MenuTypeRequestWithParamenters:parameters forView:self.view Result:^(MenuList *menulist) {
        _menulistarray = menulist;
        NSLog(@"这里%@",_menulistarray);
        [self.tableView reloadData];
    }];
    
    self.title = [NSString stringWithFormat:@"%@",_menutypearray[_idrow]];

    
    
}


    
    


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _menulistarray.MenuList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    saveTableViewCell* cell = [saveTableViewCell cellWithTableView:tableView];

    MenuListModel* model = _menulistarray.MenuList[indexPath.row];
    cell.title.text = [NSString stringWithFormat:@"%@",model.Name];
    
    
    NSString* imageurl = [NSString stringWithFormat:@"http://tnfs.tngou.net/img%@",model.ImageUrl];
    NSURL *url = [NSURL URLWithString:imageurl];
    
    [cell.imageview setImageWithURL:url placeholderImage:[UIImage imageNamed:@"holderPic.jpg"]];
    
    return cell;

    
    return cell;
    
    
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuMakeTableViewController* menu = [[MenuMakeTableViewController alloc]init];
    MenuListModel* model = _menulistarray.MenuList[indexPath.row];
    
    
    menu.idmake = [NSString stringWithFormat:@"%@",model.Id];
    [self.navigationController pushViewController:menu animated:YES];
}





@end
