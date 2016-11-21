//
//  CustomCollectionViewController.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/14.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//
#import "MakeMenuCollectionViewController.h"
#import "CustomCollectionViewController.h"
#import "CustomCollectionViewCell.h"
#import "LeanCloudTool.h"
#import "DiyMenuModel.h"
#import "UserInfoModel.h"
#import "CusDetailCollectionViewController.h"
@interface CustomCollectionViewController ()
@property NSMutableArray* diymenuarray;
@property UIRefreshControl *refreshControl;
@end

@implementation CustomCollectionViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    // 刷新控件
       self.refreshControl = [[UIRefreshControl alloc] init];
       self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull To Refresh"];
       self.refreshControl.tintColor = [UIColor greenColor];
       [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.refreshControl];
    
    
    
    
    [self.collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"CustomMenuCell"];
    UIButton *releaseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    releaseButton.frame = CGRectMake(0, 0, 60, 30);
    [releaseButton setTitle:@"去写菜谱" forState:normal];
    
    [releaseButton addTarget:self action:@selector(makeMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *releaseButtonItem = [[UIBarButtonItem alloc] initWithCustomView:releaseButton];
    self.navigationItem.rightBarButtonItem = releaseButtonItem;
    
    LeanCloudTool* tool = [LeanCloudTool sharedNetworkMng];
    [tool DiyMenuWithParamenters:nil forView:self.view Result:^(NSMutableArray *DiyMenuInfoList) {
        _diymenuarray = DiyMenuInfoList;
        [self.collectionView reloadData];
       
    }];

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
            
            LeanCloudTool* tool = [LeanCloudTool sharedNetworkMng];
            [tool DiyMenuWithParamenters:nil forView:self.view Result:^(NSMutableArray *DiyMenuInfoList) {
                _diymenuarray = DiyMenuInfoList;
                [self.collectionView reloadData];
                
            }];
        });
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
-(void)makeMenu{
    
    MakeMenuCollectionViewController *makeMenu = [[MakeMenuCollectionViewController alloc]init];
    [self.navigationController pushViewController:makeMenu animated:YES];
}
-(instancetype)init
{
    //设置流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    //    行间距
    layout.minimumInteritemSpacing = 10;
    //    组间距
    layout.minimumLineSpacing = 10;
    
    
    
    return [super initWithCollectionViewLayout:layout];
    
}




- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   if(_diymenuarray!=nil){
       return _diymenuarray.count;}
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

 CustomCollectionViewCell *cell = (CustomCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CustomMenuCell" forIndexPath:indexPath];

    cell.backgroundColor = [UIColor colorWithRed:1 green:0.97 blue:0.95 alpha:1];
    ;
    DiyMenuModel *Diymodel = _diymenuarray[indexPath.row];
    cell.username.text = Diymodel.userinfomodel.username;
     NSMutableArray *temp =  Diymodel.stepimg;
    AVFile *t = temp[0];
    [t getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if(data != nil){
        UIImage *image = [UIImage imageWithData:data];
            cell.image.image = image;}
        else{
            NSLog(@"为什么会错误%@",error);
        }
        
    }];

    [Diymodel.userinfomodel.portrait getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if(data!=nil){
        UIImage *image = [UIImage imageWithData:data];
            cell.portraitimag.image = image;}
        else{
            NSLog(@"为什么%@",error);
        }
        
    }];

    cell.experience.text=Diymodel.experience;
    cell.dishname.text = Diymodel.menuName;
return cell;
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CusDetailCollectionViewController* detail = [[CusDetailCollectionViewController alloc]init];
    detail.DiyModel = _diymenuarray[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
  return CGSizeMake([UIScreen mainScreen].bounds.size.width,270);
}

//配置item的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0, 5, 30,5);
}


@end
