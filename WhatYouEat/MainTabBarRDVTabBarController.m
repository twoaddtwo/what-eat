//
//  MainTabBarRDVTabBarController.m
//  WhatYouEat
//
//  Created by 赵馨雨 on 16/10/11.
//  Copyright © 2016年 赵馨雨. All rights reserved.
//

#import "MainTabBarRDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "saveTableViewController.h"
#import "diysaveCollectionViewController.h"
#import "JRSegmentViewController.h"
#import "FirstCollectionViewController.h"
#import "CustomCollectionViewController.h"
#import "MyTableViewController.h"
#import "diysaveCollectionViewController.h"
@interface MainTabBarRDVTabBarController ()

@end

@implementation MainTabBarRDVTabBarController

- (void)viewDidLoad {
        [super viewDidLoad];
        // Do any additional setup after loading the view.
        FirstCollectionViewController *firstViewController = [[FirstCollectionViewController alloc] init];
    
        firstViewController.title=@"首页";
        firstViewController.view.backgroundColor = [UIColor redColor];
        UIViewController *firstNavigationController = [[UINavigationController alloc]initWithRootViewController:firstViewController];
        
        
        
       CustomCollectionViewController *secondViewController = [[CustomCollectionViewController alloc] init];
        secondViewController.title=@"自制菜谱";
    secondViewController.collectionView.backgroundColor = [UIColor whiteColor];
        UIViewController *secondNavigationController = [[UINavigationController alloc]initWithRootViewController:secondViewController];
        
    MyTableViewController *myViewController = [[MyTableViewController alloc] init];
    myViewController.title=@"我的";
    myViewController.view.backgroundColor=[UIColor whiteColor];
    UIViewController *myNavigationController = [[UINavigationController alloc]initWithRootViewController:myViewController];
    
    
    diysaveCollectionViewController *diysave=[[diysaveCollectionViewController alloc]init];
    saveTableViewController* save = [[saveTableViewController alloc]init];
    JRSegmentViewController *vc = [[JRSegmentViewController alloc] init];
    vc.segmentBgColor = [UIColor colorWithRed:229.0f/255 green:59.0f/255 blue:54.0f/255 alpha:1.0f];
    vc.indicatorViewColor = [UIColor whiteColor];
    vc.titleColor = [UIColor whiteColor];
    
    [vc setViewControllers:@[save, diysave]];
    [vc setTitles:@[@"菜谱", @"diy"]];
  

    UIViewController *saveNavigationController = [[UINavigationController alloc]initWithRootViewController:vc];
    
        [self setViewControllers:@[firstNavigationController,secondNavigationController,saveNavigationController,myNavigationController]];
        
        
        NSArray *tabBarItemImages = @[@"首页", @"diy",@"收藏",@"我的"];
        NSArray *tabBarItemTitles = @[@"首页",@"自制",@"收藏",@"我的"];
        RDVTabBar *tabBar = [self tabBar];
        
        [tabBar setFrame:CGRectMake(CGRectGetMinX(tabBar.frame), CGRectGetMinY(tabBar.frame), CGRectGetWidth(tabBar.frame), 63)];
    
   
        NSInteger index = 0;
        for (RDVTabBarItem *item in [[self tabBar] items]) {
          
            UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@-t",
                                                          [tabBarItemImages objectAtIndex:index]]];
            UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",
                                                            [tabBarItemImages objectAtIndex:index]]];
            [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
            item.title=tabBarItemTitles[index];
            index++;
        }
        
        
    }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
