//
//  alreadyissueDetailCollectionViewController.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/26.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import "alreadyissueDetailCollectionViewController.h"
#import "CusDetailCollectionViewController.h"
#import "CustomCollectionViewCell.h"
#import<MBProgressHUD.h>
#import "MBProgressHUD+ROHUD.h"
#import "CusDetailCollectionViewCell.h"
@interface alreadyissueDetailCollectionViewController ()

@end

@implementation alreadyissueDetailCollectionViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[CusDetailCollectionViewCell class] forCellWithReuseIdentifier:@"myCusDetailCell"];

    UIButton *releaseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    releaseButton.frame = CGRectMake(0, 0, 60, 30);
    [releaseButton setTitle:@"删除" forState:normal];
    
    [releaseButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *releaseButtonItem = [[UIBarButtonItem alloc] initWithCustomView:releaseButton];
    self.navigationItem.rightBarButtonItem = releaseButtonItem;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)save{
    NSString *id = _DiyModel.menuId;
    
    
    AVObject *todo =[AVObject objectWithClassName:@"DiyMenuList" objectId:id];
    
    [todo deleteInBackground];
    
    [MBProgressHUD showDelayHUDToView:self.view message:@"删除成功"];
    [self.navigationController popViewControllerAnimated:YES];
    
    
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

    
  
        return _DiyModel.stepimg.count-1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
        CusDetailCollectionViewCell *cell = ( CusDetailCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"myCusDetailCell" forIndexPath:indexPath];
        
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
