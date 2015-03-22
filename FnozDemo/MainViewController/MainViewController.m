//
//  MainViewController.m
//  FnozDemo
//
//  Created by Fnoz on 15/3/21.
//  Copyright (c) 2015年 Fnoz. All rights reserved.
//

#import "MainViewController.h"
#import "ChildViewController.h"

#define    numOfPage    4
#define    BLUE        [UIColor colorWithRed:38.0f/255.0f green:145.0/255.0f blue:244.0f/255.0f alpha:1.0f]
#define    WHITE       [UIColor whiteColor]
#define    BLACK       [UIColor blackColor]

/*Used Tag:10,11,12,13,20,21,22,23,30*/

@interface MainViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    int currentPage;
    BOOL isLoading;
    NSMutableArray *numOfItemArray;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation MainViewController

- (void)initVariables
{
    currentPage = 0;
    isLoading = NO;
    numOfItemArray = [[NSMutableArray alloc] init];
    for(int i=0;i<numOfPage;i++)
    {
        [numOfItemArray addObject:[NSNumber numberWithInt:8]];
    }
}

- (void)viewDidLoad {
    [self initVariables];
    [super viewDidLoad];
    [self.view setBackgroundColor:WHITE];
    [self.navigationItem setTitle:@"FnozDemo"];
    [self.navigationController.interactivePopGestureRecognizer setEnabled:NO];
    
    UIButton *btn0 = [[UIButton alloc] initWithFrame:CGRectMake(30.0f, 100.0f, 50.0f, 25.0f)];
    [btn0 setTitle:@"Life" forState:UIControlStateNormal];
    [btn0 setBackgroundColor:BLUE];
    [btn0 setTitleColor:WHITE forState:UIControlStateNormal];
    [btn0 setTag:10];
    [btn0 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn0.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.view addSubview:btn0];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(30.0f+70.0f, 100.0f, 50.0f, 25.0f)];
    [btn1 setTitle:@"Social" forState:UIControlStateNormal];
    [btn1 setBackgroundColor:WHITE];
    [btn1 setTitleColor:BLACK forState:UIControlStateNormal];
    [btn1 setTag:11];
    [btn1 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn1.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(30.0f+140.0f, 100.0f, 50.0f, 25.0f)];
    [btn2 setTitle:@"Tech" forState:UIControlStateNormal];
    [btn2 setBackgroundColor:WHITE];
    [btn2 setTitleColor:BLACK forState:UIControlStateNormal];
    [btn2 setTag:12];
    [btn2 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn2.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(30.0f+210.0f, 100.0f, 50.0f, 25.0f)];
    [btn3 setTitle:@"Local" forState:UIControlStateNormal];
    [btn3 setBackgroundColor:WHITE];
    [btn3 setTitleColor:BLACK forState:UIControlStateNormal];
    [btn3 setTag:13];
    [btn3 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn3.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.view addSubview:btn3];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(30.0f, 150.0f, 260.0f, 320.0f)];
    [_scrollView setBackgroundColor:[UIColor clearColor]];
    [_scrollView setPagingEnabled:YES];
    [_scrollView setDelegate:self];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [_scrollView setBounces:NO];
    [_scrollView setContentSize:CGSizeMake(260.0f*numOfPage, 320.0f)];
    [self.view addSubview:_scrollView];
    
    for (int i=0; i<numOfPage; i++)
    {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(i*260.0f, 0, 260.0f, 320.0f)];
        [tableView setBackgroundColor:[UIColor clearColor]];
        [tableView setDelegate:self];
        [tableView setDataSource:self];
        [tableView setClipsToBounds:YES];
        [tableView setBounces:YES];
        [tableView setTag:20+i];
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [tableView setTableFooterView:[[UIView alloc] init]];
        [tableView setTableHeaderView:[[UIView alloc] init]];
        [_scrollView addSubview:tableView];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)refreshBtn:(int)page
{
    for (int i=0; i<numOfPage; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:i+10];
        if (i == page)
        {
            [btn setBackgroundColor:BLUE];
            [btn setTitleColor:WHITE forState:UIControlStateNormal];
        }
        else
        {
            [btn setBackgroundColor:WHITE];
            [btn setTitleColor:BLACK forState:UIControlStateNormal];
        }
    }
}

- (void)btnClicked:(UIButton *)btn
{
    currentPage = [btn tag]-10;
    [self refreshBtn:currentPage];
    CGFloat width = _scrollView.frame.size.width;
    CGPoint contentOffset = CGPointMake(width*currentPage, _scrollView.contentOffset.y);
    [self refreshBtn:currentPage];
    [UIView animateWithDuration:0.2 animations:^{
        _scrollView.contentOffset = contentOffset;
    } completion:^(BOOL finished) {
    }];
}

#pragma mark -
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (![scrollView isEqual:_scrollView])
        return;
    CGFloat width = scrollView.frame.size.width;
    int page = scrollView.contentOffset.x/width;
    currentPage = page;
    [self refreshBtn:currentPage];
}

#pragma mark -
#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[numOfItemArray objectAtIndex:[tableView tag]-20] intValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"FnozRefreshTableViewCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    NSString *itemStr = [NSString stringWithFormat:@"This %d.%d", [tableView tag]-20, (int)indexPath.row];
    [cell.textLabel setText:itemStr];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ChildViewController *vc = [[ChildViewController alloc] init];
    [vc setTabNum:currentPage];
    [vc setLineNum:(int)indexPath.row];
    [(FnozNaviViewController *)self.navigationController pushViewController:vc animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    __block int numOfItems = [[numOfItemArray objectAtIndex:[tableView tag]-20] intValue];
    if (indexPath.row == numOfItems - 1) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 50.0f)];
        __block UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(100.0f, 0.0f, 60.0f, 60.0f)];
        [activity setColor:BLUE];
        [footerView addSubview:activity];
        [activity startAnimating];
        tableView.tableFooterView = footerView;
        
        numOfItems += 4;
        [numOfItemArray replaceObjectAtIndex:[tableView tag]-20 withObject:[NSNumber numberWithInt:numOfItems]];
        [tableView reloadData];
    }
    else
    {
        tableView.tableFooterView = nil;
    }
}

@end
