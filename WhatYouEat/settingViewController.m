//
//  settingViewController.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/22.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import "settingViewController.h"
#import <AVOSCloud/AVOSCloud.h>
@interface settingViewController ()

@end

@implementation settingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkImageClicked:)];
    _UserPortrait.userInteractionEnabled=YES;
    [_UserPortrait addGestureRecognizer:tapGesturRecognizer];
    
    
    [_UserPortrait.layer setCornerRadius:CGRectGetHeight([_UserPortrait bounds]) / 2];
    _UserPortrait.layer.masksToBounds = YES;
    
   _username.text = _model.username;
    AVFile *file = _model.portrait;
    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        UIImage *image = [UIImage imageWithData:data];
      _UserPortrait.image = image;
    }];
    _email.text = _model.email;
    _password.text = _model.password;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)saveImage:(UIImage *)image {
    
    
    UIImage *smallImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(60,60)];
    
    
    _UserPortrait.image = smallImage;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{        [picker dismissViewControllerAnimated:YES completion:nil];
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



- (IBAction)saveuserInfo:(id)sender {
    
    
    NSString* id=_model.userId;
    //先删除对应的id的用户
    AVObject *todo =[AVObject objectWithClassName:@"UserList" objectId:id];
    
    [todo deleteInBackground];
    
    
    //再保存
    
    
    
    NSString *username = self.username.text;
    NSString *password = self.password.text;
    NSString *email = self.email.text;

    NSData *data = UIImagePNGRepresentation(_UserPortrait.image);
    AVFile *file = [AVFile fileWithData:data];
    
    AVObject *UserList = [AVObject objectWithClassName:@"UserList"];
    AVQuery *query = [AVQuery queryWithClassName:@"UserList"];
    [query whereKey:@"email" equalTo:email];
    [query getFirstObjectInBackgroundWithBlock:^(AVObject *object, NSError *error) {
        if(object != nil){
            NSLog(@"用户已经存在");
        }
        else{
            NSLog(@"用户不存在");
            [UserList setObject:username forKey:@"username"];
            [UserList setObject:password forKey:@"password"];
            [UserList setObject:email forKey:@"email"];
            [UserList setObject:file forKey:@"portrait"];
            [UserList saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    NSLog(@"CHENGGONG!!!!!!!");
                } else {
                    NSLog(@"用户注册失败 %@", error);
                }
            }];
            
            
        }
    }];
    
    
    

    
    
    
    
    
}
@end
