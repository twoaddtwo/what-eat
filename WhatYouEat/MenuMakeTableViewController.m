//
//  MenuMakeTableViewController.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/13.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import "MenuMakeTableViewController.h"
#import "NetworkingTool.h"
#import "DetailMakeModel.h"
#import<MBProgressHUD.h>
#import "MBProgressHUD+ROHUD.h"
#import "saveTableViewController.h"
#import "MenuMakeTableViewCell.h"
@interface MenuMakeTableViewController ()
@property DetailMakeModel* model;
@end

@implementation MenuMakeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    
    UIButton *releaseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    releaseButton.frame = CGRectMake(0, 0, 30, 30);
    [releaseButton setTitle:@"收藏" forState:normal];
    
    [releaseButton addTarget:self action:@selector(saveMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *releaseButtonItem = [[UIBarButtonItem alloc] initWithCustomView:releaseButton];
    self.navigationItem.rightBarButtonItem = releaseButtonItem;

    
    NSDictionary* parameters = @{@"id":_idmake};
    
    NetworkingTool* tool = [NetworkingTool sharedNetworkMng];
    [tool MenuMakeRequestWithParamenters:parameters forView:self.view Result:^(DetailMakeModel *menumake) {
        _model = menumake;
        NSLog(@"这是什么%@",_model);
        [self.tableView reloadData];
    }];

}

-(void)saveMenu{
    

    
    [self savearray];
    
    

    
}
-(void)savearray{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
  
   

    NSString *filename=[plistPath stringByAppendingPathComponent:@"SAVE.plist"];
    if( [[NSFileManager defaultManager] fileExistsAtPath:filename]){
        NSArray* tem = [NSArray arrayWithContentsOfFile:filename];
        NSMutableArray *marr = [NSMutableArray arrayWithArray:tem];
        [marr addObject:_idmake];
        [marr writeToFile:filename atomically:YES];
        
    }
    
    else{
        NSMutableArray* array = [NSMutableArray array];
        [array insertObject:_idmake atIndex:0];
        [array writeToFile:filename atomically:YES];
    }

   [MBProgressHUD showDelayHUDToView:self.view message:@"保存成功"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MenuMakeTableViewCell* cell = [MenuMakeTableViewCell cellWithTableView:tableView];
    cell.MenuMakeText.text = [NSString stringWithFormat:@"%@",_model.message];

    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://tnfs.tngou.net/image%@",_model.ImageUrl]];
    cell.img.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    

    cell.nameLabel.text = [NSString stringWithFormat:@"%@",_model.Name];


   
    

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UIScreen mainScreen].bounds.size.height-60;
}
@end
