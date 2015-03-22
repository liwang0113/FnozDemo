//
//  FnozChildViewController.m
//  e-Control
//
//  Created by Fnoz on 15/3/20.
//  Copyright (c) 2015年 BroadLink. All rights reserved.
//

#import "ChildViewController.h"

#define    BLUE        [UIColor colorWithRed:38.0f/255.0f green:145.0/255.0f blue:244.0f/255.0f alpha:1.0f]

@interface ChildViewController ()

@end

@implementation ChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BLUE];
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(50.0f, 250.0f, 220.0f, 50.0f)];
    [textLabel setText:[NSString stringWithFormat:@"This is %d.%d",self.tabNum,self.lineNum]];
    [textLabel setTextAlignment:NSTextAlignmentCenter];
    [textLabel setTextColor:[UIColor whiteColor]];
    [textLabel setFont:[UIFont systemFontOfSize:20.0f]];
    [self.view addSubview:textLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
