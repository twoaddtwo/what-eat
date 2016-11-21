//
//  ViewController.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/10.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import "ViewController.h"
#import<MBProgressHUD.h>
#import "MBProgressHUD+ROHUD.h"
#import <AVOSCloud/AVOSCloud.h>
#import "MainTabBarRDVTabBarController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UILabel *whateat;
- (IBAction)Login:(id)sender;
- (IBAction)sign:(id)sender;
@property JSAnimatedImagesView* animatedImagesView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _whateat.font = [UIFont fontWithName:@"Zapfino" size:40];
    
    //设置文本高亮
    _whateat.highlighted = YES;

    _whateat.highlightedTextColor = [UIColor whiteColor];
    
    _animatedImagesView = [[JSAnimatedImagesView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.animatedImagesView.dataSource = self;
    [self.view addSubview:_animatedImagesView];
    [self.view sendSubviewToBack:_animatedImagesView];
    
 
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (IBAction)Login:(id)sender
{
    NSString *email = self.email.text;
    NSString *password = self.password.text;

   
    AVQuery *query = [AVQuery queryWithClassName:@"UserList"];
    [query whereKey:@"email" equalTo:email];
    [query whereKey:@"password" equalTo:password];
   
[query getFirstObjectInBackgroundWithBlock:^(AVObject *object, NSError *error) {
    if(object != nil){
        
        [[NSUserDefaults standardUserDefaults]setObject:email forKey:@"email"];
           [[NSUserDefaults standardUserDefaults]setBool:YES  forKey:@"ifLogin"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        
        MainTabBarRDVTabBarController *mainController = [[MainTabBarRDVTabBarController alloc]init];
        [self presentViewController:mainController animated:YES completion:nil];
        
        
        
    }
    else{
        NSLog(@"用户不存在");
        [MBProgressHUD showDelayHUDToView:self.view message:@"登录失败"];
        
    }
}];
    
    

    

    
}

- (IBAction)sign:(id)sender {
}
@end
