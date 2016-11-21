//
//  CusDetailCollectionViewController.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/17.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import "CusDetailCollectionViewController.h"
#import "CustomCollectionViewCell.h"
#import<MBProgressHUD.h>
#import "MBProgressHUD+ROHUD.h"
#import "CusDetailCollectionViewCell.h"
@interface CusDetailCollectionViewController ()

@end

@implementation CusDetailCollectionViewController

//static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    
   
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[CusDetailCollectionViewCell class] forCellWithReuseIdentifier:@"CusDetailCell"];
    [self.collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"CustomCell"];
    UIButton *releaseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    releaseButton.frame = CGRectMake(0, 0, 60, 30);
    [releaseButton setTitle:@"收藏" forState:normal];
    
    [releaseButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *releaseButtonItem = [[UIBarButtonItem alloc] initWithCustomView:releaseButton];
    self.navigationItem.rightBarButtonItem = releaseButtonItem;

    
  }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)save{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    
    
    
    NSString *filename=[plistPath stringByAppendingPathComponent:@"SAVEdiy.plist"];
    if( [[NSFileManager defaultManager] fileExistsAtPath:filename]){
        NSArray* tem = [NSArray arrayWithContentsOfFile:filename];
        NSMutableArray *marr = [NSMutableArray arrayWithArray:tem];
        [marr addObject:_DiyModel.menuId];
        [marr writeToFile:filename atomically:YES];
        
    }
    
    else{
        NSMutableArray* array = [NSMutableArray array];
        [array insertObject:_DiyModel.menuId atIndex:0];
        [array writeToFile:filename atomically:YES];
    }
    
    [MBProgressHUD showDelayHUDToView:self.view message:@"保存成功"];
    
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
    
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section == 0){
        return 1;}

    else{
        return _DiyModel.stepimg.count-1;}
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        
        
        CustomCollectionViewCell *cell = ( CustomCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCell" forIndexPath:indexPath];
      cell.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.1];
        cell.username.text = _DiyModel.userinfomodel.username;
        NSMutableArray *temp =  _DiyModel.stepimg;
        AVFile *t = temp[0];
        [t getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if(data != nil){
                UIImage *image = [UIImage imageWithData:data];
                cell.image.image = image;}
            else{
                NSLog(@"为什么会错误%@",error);
            }
            
        }];
        
        [_DiyModel.userinfomodel.portrait getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if(data!=nil){
                UIImage *image = [UIImage imageWithData:data];
                cell.portraitimag.image = image;}
            else{
                NSLog(@"为什么%@",error);
            }
            
        }];
        
        cell.experience.text=_DiyModel.experience;
        cell.dishname.text = _DiyModel.menuName;
        
        return cell;
        
    }
    else {
        CusDetailCollectionViewCell *cell = ( CusDetailCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CusDetailCell" forIndexPath:indexPath];
     
        cell.stepName.text = _DiyModel.stepname[indexPath.row];
        
        NSMutableArray *temp =  _DiyModel.stepimg;
        AVFile *t = temp[indexPath.row+1];
        [t getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if(data != nil){
                UIImage *image = [UIImage imageWithData:data];
                cell.stepImg.image = image;}
            else{
                NSLog(@"为什么会错误%@",error);
            }
            
        }];

        
        
        
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
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {return CGSizeMake([UIScreen mainScreen].bounds.size.width,400);
    }
    else
        return CGSizeMake([UIScreen mainScreen].bounds.size.width,300);
    
}

//配置item的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if(section==0){
        return UIEdgeInsetsMake(0, 0, 10,0);
    }
    else return UIEdgeInsetsMake(0, 0, 10,0);
}


@end
