//
//  diysaveCollectionViewController.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/22.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//
#import "DiyDetailCollectionViewController.h"
#import "diysaveCollectionViewController.h"
#import "LeanCloudTool.h"
#import "DiyMenuModel.h"
#import "UserInfoModel.h"
#import "diysaveCollectionViewCell.h"
@interface diysaveCollectionViewController ()
@property NSMutableArray* savearray;
@property NSMutableArray* saveArray;
@property UIRefreshControl *refreshControl;
@end

@implementation diysaveCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
        [self.collectionView registerClass:[diysaveCollectionViewCell class] forCellWithReuseIdentifier:@"saveCustomMenuCell"];
    // 刷新控件
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull To Refresh"];
    self.refreshControl.tintColor = [UIColor greenColor];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.refreshControl];
    [self getdata];
  
    self.collectionView.backgroundColor = [UIColor whiteColor];


    
}
-(void)getdata{
    _savearray = [NSMutableArray array];
    _saveArray = [NSMutableArray array];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    
    NSString *filename=[plistPath stringByAppendingPathComponent:@"SAVEdiy.plist"];
    NSArray* array = [NSArray arrayWithContentsOfFile:filename];
    _savearray = [NSMutableArray arrayWithArray:array];
    
    for(int i=0;i<_savearray.count;i++){
        LeanCloudTool *tool = [LeanCloudTool sharedNetworkMng];
        [tool DiyMenuWithId:_savearray[i] forView:self.view Result:^(DiyMenuModel *IdInfo) {
            [_saveArray addObject:IdInfo];
            [self.collectionView reloadData];
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
           
       
        });
    });
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
    if(_saveArray!=nil){
        return _saveArray.count;}
    else return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
  diysaveCollectionViewCell *cell = (diysaveCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"saveCustomMenuCell" forIndexPath:indexPath];
     cell.backgroundColor = [UIColor colorWithRed:0.9 green:0.5 blue:0.4 alpha:0.1];
    DiyMenuModel *Diymodel = _saveArray[indexPath.row];

    NSMutableArray *temp = Diymodel.stepimg;
    AVFile *t = temp[0];
    [t getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if(data != nil){
            UIImage *image = [UIImage imageWithData:data];
            cell.image.image = image;}
        else{
            NSLog(@"为什么会错误%@",error);
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
    DiyDetailCollectionViewController* detail = [[DiyDetailCollectionViewController alloc]init];
    detail.DiyModel = _saveArray[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width,200);
}

//配置item的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0, 0, 60,0);
}




@end
