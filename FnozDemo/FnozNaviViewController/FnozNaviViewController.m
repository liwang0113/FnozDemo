//
//  FnozNaviViewController.m
//  e-Control
//
//  Created by Fnoz on 15/3/20.
//  Copyright (c) 2015年 BroadLink. All rights reserved.
//

#import "FnozNaviViewController.h"

#define  TOP_VIEW  [[[[UIApplication sharedApplication] keyWindow] rootViewController] view]  //fnoztodo

@interface FnozNaviViewController ()
{
    BOOL panForBack;
}

@property (nonatomic, strong) NSMutableArray *savedPicArray;
@property (nonatomic, strong) UIImageView *downView;

@end

@implementation FnozNaviViewController

- (void)initVariables
{
    panForBack = NO;
    _savedPicArray = [[NSMutableArray alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initVariables];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    [self.view addGestureRecognizer:panGesture];
}

- (void)dealloc
{
    [self setSavedPicArray:nil];
    [self setDownView:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark - Push & Pop
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIImage *snapshot = [self getImageOfView:self.view];
    if (snapshot)
        [_savedPicArray addObject:snapshot];
    [super pushViewController:viewController animated:animated];
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    [_savedPicArray removeObjectAtIndex:[_savedPicArray count]-1];
    [super popViewControllerAnimated:animated];
    return nil;
}

- (UIImage *)getImageOfView:(UIView *)view  //fnoztodo
{
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:currnetContext];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)panGestureAction:(UIPanGestureRecognizer *)theGesture
{
    if([_savedPicArray count] <= 1)
        return ;
    CGPoint point = [theGesture locationInView:[[UIApplication sharedApplication] keyWindow]];  //fnoztodo
    if (theGesture.state == UIGestureRecognizerStateBegan && point.x<50.0f)
    {
        panForBack = YES;
        _downView = [[UIImageView alloc] initWithFrame:CGRectMake(-TOP_VIEW.frame.size.width, 0, TOP_VIEW.frame.size.width, TOP_VIEW.frame.size.height)];
        [_downView setFrame:TOP_VIEW.bounds];
        _downView.image = [_savedPicArray objectAtIndex:[_savedPicArray count]-1];
        [TOP_VIEW.superview insertSubview:_downView belowSubview:TOP_VIEW];
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = TOP_VIEW.frame;
            frame.origin.x = point.x;
            TOP_VIEW.frame = frame;
        } completion:^(BOOL finished) {
        }];
    }
    else if (theGesture.state == UIGestureRecognizerStateChanged && panForBack)
    {
        CGRect viewFrame = TOP_VIEW.frame;
        viewFrame.origin.x = point.x;
        TOP_VIEW.frame = viewFrame;
        [_downView setCenter:CGPointMake(viewFrame.origin.x/2, _downView.frame.size.height/2.0f)];
    }
    else
    {
        panForBack = NO;
        if(point.x > 120.0f)
        {
            __block CGRect viewFrame = TOP_VIEW.frame;
            [UIView animateWithDuration:0.2 animations:^{
                viewFrame.origin.x = viewFrame.size.width;
                TOP_VIEW.frame = viewFrame;
                [_downView setFrame:CGRectMake(0, 0, TOP_VIEW.frame.size.width, TOP_VIEW.frame.size.height)];
            } completion:^(BOOL finished) {
                [self popViewControllerAnimated:NO];
                viewFrame.origin.x = 0;
                TOP_VIEW.frame = viewFrame;
            }];
        }
        else
        {
            __block CGRect viewFrame = TOP_VIEW.frame;
            [UIView animateWithDuration:0.2 animations:^{
                viewFrame.origin.x = 0;
                TOP_VIEW.frame = viewFrame;
                [TOP_VIEW setFrame:viewFrame];
                [_downView setFrame:CGRectMake(-TOP_VIEW.frame.size.width, 0, TOP_VIEW.frame.size.width, TOP_VIEW.frame.size.height)];
            } completion:^(BOOL finished) {
            }];
        }
    }
}

@end