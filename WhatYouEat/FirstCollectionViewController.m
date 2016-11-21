//
//  FirstCollectionViewController.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/12.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//
#import <UIImageView+AFNetworking.h>
#import "FirstCollectionViewController.h"
#import "FirstTypeCollectionViewCell.h"
#import "ScrollCollectionViewCell.h"
#import "Image&labelCollectionViewCell.h"
#import "NetworkingTool.h"
#import "MenuListModel.h"
#import "MenuList.h"
#import "MenuTypeDetailListTableViewController.h"
#import "MenuMakeTableViewController.h"
@interface FirstCollectionViewController ()
@property NSArray* menutypearray;
@property MenuList* menulistarray;
@property NSArray* menutypeimgarray;
@end

@implementation FirstCollectionViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor colorWithRed:1 green:0.97 blue:0.95 alpha:1];
    
    [self.collectionView registerClass:[FirstTypeCollectionViewCell class] forCellWithReuseIdentifier:@"firstTypeCell"];
     [self.collectionView registerClass:[ScrollCollectionViewCell class] forCellWithReuseIdentifier:@"scrollCell"];
    [self.collectionView registerClass:[Image_labelCollectionViewCell class] forCellWithReuseIdentifier:@"image_labelCell"];
    
    
    NetworkingTool* tool = [NetworkingTool sharedNetworkMng];
    [tool MenuTypeRequestWithParamenters:nil forView:self.view Result:^(MenuList* menulist) {
        _menulistarray = menulist;
        [self.collectionView reloadData];
      
    }];
    _menutypeimgarray = @[@"0.jpg",@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpg",@"9.jpg"];
  
    _menutypearray = @[@"美容",@"减肥",@"保健养生",@"人群",@"时节",@"餐时",@"器官",@"调养",@"肠胃消化",@"孕产哺乳"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
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

    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if(section == 0)
    {return 1;}
    else if(section == 1){
        return _menutypearray.count;
    }
    else if(section == 2){
       return _menulistarray.MenuList.count;
    }
    else
        return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
    
        
        ScrollCollectionViewCell *cell = (ScrollCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"scrollCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor redColor];
        
        
        return cell;
    
    }
    else if(indexPath.section == 1){
   
        FirstTypeCollectionViewCell *cell = (FirstTypeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"firstTypeCell" forIndexPath:indexPath];
           cell.label.text = [NSString stringWithFormat:@"%@",_menutypearray[indexPath.row]];
        cell.image.image = [UIImage imageNamed:_menutypeimgarray[indexPath.row]];
        
        return cell;
    }
    else if(indexPath.section == 2){
                Image_labelCollectionViewCell *cell = (Image_labelCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"image_labelCell" forIndexPath:indexPath];
     MenuListModel* model = _menulistarray.MenuList[indexPath.row];
        cell.label.text = [NSString stringWithFormat:@"%@",model.Name];
        
        NSString* imageurl = [NSString stringWithFormat:@"http://tnfs.tngou.net/img%@",model.ImageUrl];
          NSURL *url = [NSURL URLWithString:imageurl];

            [cell.imagess setImageWithURL:url placeholderImage:[UIImage imageNamed:@"holderPic.jpg"]];
      
        return cell;
    }
    else{
                UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
        return cell;
    }
   
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1){
    MenuTypeDetailListTableViewController* detail = [[MenuTypeDetailListTableViewController alloc]init];
    detail.idrow = indexPath.row;
        [self.navigationController pushViewController:detail animated:YES];
    }
    else if(indexPath.section==2){
        MenuMakeTableViewController* menu = [[MenuMakeTableViewController alloc]init];
        MenuListModel* model = _menulistarray.MenuList[indexPath.row];
        
        
        menu.idmake = [NSString stringWithFormat:@"%@",model.Id];
        [self.navigationController pushViewController:menu animated:YES];
        
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
        return CGSizeMake([UIScreen mainScreen].bounds.size.width,200);
    }
    else if(indexPath.section == 1){
        return CGSizeMake(([UIScreen mainScreen].bounds.size.width-120)/5,([UIScreen mainScreen].bounds.size.width-120)/5);
    }
    else return CGSizeMake([UIScreen mainScreen].bounds.size.width,200);
}

//配置item的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if(section==0){
        return UIEdgeInsetsMake(0, 0, 10,0);
    }
    else if(section == 1){
        return UIEdgeInsetsMake(0, 20, 10,20);
    }
    else return UIEdgeInsetsMake(0, 0, 10,0);
}


@end
