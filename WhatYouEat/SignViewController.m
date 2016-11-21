//
//  SignViewController.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/14.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//
#import<MBProgressHUD.h>
#import "MBProgressHUD+ROHUD.h"
#import "SignViewController.h"
#import <AVOSCloud/AVOSCloud.h>
@interface SignViewController ()
@property(nonatomic, strong) NSData *fileData;
@property JSAnimatedImagesView* animatedImagesView;
@end

@implementation SignViewController



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    _animatedImagesView = [[JSAnimatedImagesView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.animatedImagesView.dataSource = self;
    [self.view addSubview:_animatedImagesView];
    [self.view sendSubviewToBack:_animatedImagesView];
    
    
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkImageClicked:)];
    _userPortrait.userInteractionEnabled=YES;
    [_userPortrait addGestureRecognizer:tapGesturRecognizer];
    
    
   [_userPortrait.layer setCornerRadius:CGRectGetHeight([_userPortrait bounds]) / 2];
    _userPortrait.layer.masksToBounds = YES;
}


#pragma mark -
#pragma UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];

    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)saveImage:(UIImage *)image {
    
    
    UIImage *smallImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(50,50)];
    
    
    _userPortrait.image = smallImage;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{        [picker dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)sign:(id)sender {
    
    NSString *username = self.username.text;
    NSString *password = self.password.text;
    NSString *email = self.email.text;
    NSLog(@"我输出一下看看%@",username);
    NSData *data = UIImagePNGRepresentation(_userPortrait.image);
    AVFile *file = [AVFile fileWithData:data];
    
    AVObject *UserList = [AVObject objectWithClassName:@"UserList"];
    AVQuery *query = [AVQuery queryWithClassName:@"UserList"];
    [query whereKey:@"email" equalTo:email];
    [query getFirstObjectInBackgroundWithBlock:^(AVObject *object, NSError *error) {
        if(object != nil){
            NSLog(@"用户已经存在");
            [MBProgressHUD showDelayHUDToView:self.view message:@"用户已经存在"];
            
        }
        else{
            NSLog(@"用户不存在");
            [UserList setObject:username forKey:@"username"];
            [UserList setObject:password forKey:@"password"];
            [UserList setObject:email forKey:@"email"];
            [UserList setObject:file forKey:@"portrait"];
            [UserList saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    
                    [self dismissViewControllerAnimated:YES completion:nil];      [MBProgressHUD showDelayHUDToView:self.view message:@"注册成功"];
                    NSLog(@"CHENGGONG!!!!!!!");
                } else {
                    NSLog(@"用户注册失败 %@", error);
                    [MBProgressHUD showDelayHUDToView:self.view message:@"注册失败"];
                }
            }];

            
        }
    }];
    


    
    
    
    
    
}
- (IBAction)backToLogin:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)checkImageClicked:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}
//2.保持原来的长宽比，生成一个缩略图
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}
- (NSUInteger)animatedImagesNumberOfImages:(JSAnimatedImagesView *)animatedImagesView
{
    return 2;
}
- (UIImage *)animatedImagesView:(JSAnimatedImagesView *)animatedImagesView imageAtIndex:(NSUInteger)index
{
    //  return [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", index + 1]];
    return [UIImage imageNamed:[NSString stringWithFormat:@"background.jpg"]];
    
}
@end
