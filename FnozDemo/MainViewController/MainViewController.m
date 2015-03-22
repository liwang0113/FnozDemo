//
//  MainViewController.m
//  FnozDemo
//
//  Created by Fnoz on 15/3/21.
//  Copyright (c) 2015年 Fnoz. All rights reserved.
//

#import "MainViewController.h"
#import "ChildViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationItem setTitle:@"Fss"];
    [self.navigationController.interactivePopGestureRecognizer setEnabled:NO];
    
    UIButton *testBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    [testBtn setBackgroundColor:[UIColor greenColor]];
    [testBtn addTarget:self action:@selector(pushNewViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)pushNewViewController:(UIButton *)btn
{
    ChildViewController *vc = [[ChildViewController alloc] init];
    [(FnozNaviViewController *)self.navigationController pushViewController:vc animated:YES];
}

@end
