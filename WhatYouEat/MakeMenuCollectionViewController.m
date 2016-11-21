//
//  MakeMenuCollectionViewController.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/17.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//
#import<MBProgressHUD.h>
#import "MBProgressHUD+ROHUD.h"
#import "MakeMenuCollectionViewController.h"
#import "MakeStepCollectionViewCell.h"
#import "MakeMenuCollectionViewCell.h"
#import "AddStepCollectionViewCell.h"
#import <AVOSCloud/AVOSCloud.h>
@interface MakeMenuCollectionViewController ()

@property NSMutableArray* stepname;
@property NSMutableArray* stepimag;
@property NSString* experience;
@property NSString* material;
@property NSString* menuname;
@property UIImageView* imageMenu;
@property BOOL ifmenuimg;
@property int step;

@end

@implementation MakeMenuCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _step=1;
  
    _stepimag = [NSMutableArray array];
        _stepname = [NSMutableArray array];
    _stepimag[0]=[UIImage imageNamed:@"添加菜谱效果图.jpg"];
    for (int i = 1; i <= _step ; i++) {
        [_stepimag addObject:[UIImage imageNamed:@"添加步骤图.jpg"]];
        [_stepname addObject:[NSString stringWithFormat:@"%d",i]];
    }
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[MakeMenuCollectionViewCell class] forCellWithReuseIdentifier:@"MakeMenuCell"];
    [self.collectionView registerClass:[MakeStepCollectionViewCell class] forCellWithReuseIdentifier:@"MakeStepCell"];

    
       [self.collectionView registerClass:[AddStepCollectionViewCell class] forCellWithReuseIdentifier:@"AddStepCell"];
    UIButton *releaseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    releaseButton.frame = CGRectMake(0, 0, 30, 30);
    [releaseButton setTitle:@"发布" forState:normal];
    
    [releaseButton addTarget:self action:@selector(issueMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *releaseButtonItem = [[UIBarButtonItem alloc] initWithCustomView:releaseButton];
    self.navigationItem.rightBarButtonItem = releaseButtonItem;
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)addStep{
    if (_stepimag.count >= 1) {
        
        _step++;
        [_stepimag insertObject:[UIImage imageNamed:@"添加步骤图.jpg"] atIndex:_step];
        [_stepname addObject:[NSString stringWithFormat:@"%d",_step]];

        [self.collectionView reloadData];
    }
    
    
}
-(void)cutStep{

    if(_step >= 1){
        _step--;
        [_stepimag removeLastObject];
        [_stepname removeLastObject];
        [self.collectionView reloadData];
    }
   

}
-(void)issueMenu{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableArray *stepimage = [[NSMutableArray alloc]init];
    for(int i = 0;i<_stepimag.count;i++){
        NSData *data = UIImagePNGRepresentation(_stepimag[i]);
        AVFile *file = [AVFile fileWithData:data];
       
        [stepimage addObject:file];
    }

    
    
    NSString* useremail = [[NSUserDefaults standardUserDefaults]objectForKey:@"email"];
    AVObject *DiyMenuList = [AVObject objectWithClassName:@"DiyMenuList"];

    [DiyMenuList setObject:_menuname forKey:@"menuname"];
    [DiyMenuList setObject:_material forKey:@"material"];
    [DiyMenuList setObject:_experience forKey:@"experience"];
    [DiyMenuList setObject:stepimage forKey:@"stepimgarray"];
    [DiyMenuList setObject:_stepname forKey:@"stepnamearray"];
    [DiyMenuList setObject:useremail forKey:@"email"];
    [DiyMenuList saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
                    NSLog(@"保存菜品CHENGGONG!!!!!!!");
                } else {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    NSLog(@"保存菜品失败 %@", error);
                }
            }];
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
        return _step;
    }
    else return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0){
       MakeMenuCollectionViewCell *cell = ( MakeMenuCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MakeMenuCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.2];
        _menuname = cell.MenuName.text;
        _experience = cell.experience.text;
        _material = cell.material.text;
        
        if (_stepimag.count >0) {
            cell.image.image = _stepimag[0];
        }
        
        [cell.AddImg addTarget:self action:@selector(AddImg:) forControlEvents:UIControlEventTouchUpInside];
        

        return cell;
        
    }
    else if(indexPath.section == 1){
      
       
        MakeStepCollectionViewCell *cell = (MakeStepCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MakeStepCell" forIndexPath:indexPath];
     cell.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.2];
        cell.stepname.delegate = self;
        cell.stepname.returnKeyType = UIReturnKeyDone;
        cell.stepname.text = _stepname[indexPath.row];
            
        
      if (_stepimag.count >= _step) {
      
            cell.image.image = _stepimag[indexPath.row+1];
            
            
         }
[cell.AddImg addTarget:self action:@selector(AddImg:) forControlEvents:UIControlEventTouchUpInside];
      return cell;
    }
    else{
        AddStepCollectionViewCell *cell = (AddStepCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"AddStepCell" forIndexPath:indexPath];
cell.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.2];
        [cell.addButton addTarget:self action:@selector(addStep) forControlEvents:UIControlEventTouchUpInside];
            [cell.cutButton addTarget:self action:@selector(cutStep) forControlEvents:UIControlEventTouchUpInside];
        return cell;

    }
 
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"点%@",textField.text);
    UIView *v = [textField superview];//获取父类view
    UICollectionViewCell *cell = (UICollectionViewCell *)[v superview];//获取cell
    
    NSIndexPath *indexpath = [self.collectionView indexPathForCell:cell];//获取cell对应的indexpath;
    [_stepname replaceObjectAtIndex:indexpath.row withObject:textField.text];
    [textField resignFirstResponder];
    return YES;
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
    if(indexPath.section == 2)
    {return CGSizeMake([UIScreen mainScreen].bounds.size.width,50);
    }
    else if(indexPath.section == 1){
        return CGSizeMake([UIScreen mainScreen].bounds.size.width,200);
    }
    return CGSizeMake([UIScreen mainScreen].bounds.size.width,400);

}

//配置item的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if(section==0){
        return UIEdgeInsetsMake(0, 0, 10,0);
    }
    else return UIEdgeInsetsMake(0, 0, 10,0);
}



-(void)AddImg:(UIButton *)sender{
    
    UIView *v = [sender superview];//获取父类view
    UICollectionViewCell *cell = (UICollectionViewCell *)[v superview];//获取cell
    
    NSIndexPath *indexpath = [self.collectionView indexPathForCell:cell];//获取cell对应的indexpath;
    if(indexpath.section == 1){
        _ifmenuimg = NO;
            UIImage *tempImage = _stepimag[0];
            UIImage *tempImage1 = [UIImage imageNamed:@"添加菜谱效果图.jpg"];
            if ([tempImage isEqual:tempImage1])
            {
                NSLog(@"set header image first!");
            }
        
            else{
       
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;
                picker.allowsEditing = YES;
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:picker animated:YES completion:nil];
                }
       }
    else if(indexpath.section == 0){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
        _ifmenuimg = YES;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    if(_ifmenuimg){
        [_stepimag replaceObjectAtIndex:0 withObject:img];
    }

        else
        {
            [_stepimag replaceObjectAtIndex:_step withObject:img];
        }
  
    [self.collectionView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{        [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
