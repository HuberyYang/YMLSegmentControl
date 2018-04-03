//
//  HYViewController.m
//  YMLSegmentControl
//
//  Created by 569738793@qq.com on 04/03/2018.
//  Copyright (c) 2018 569738793@qq.com. All rights reserved.
//

#import "HYViewController.h"
#import <YMLSegmentControl/YMLSegmentControl.h>

@interface HYViewController ()<YMLSegmentControlDelegate>

@end

@implementation HYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSArray *titles = @[@"一",@"第二",@"第三个",@"四个",@"这是第五",@"第六",@"第七",@"第八",@"第九"];
    __weak typeof(self) weakSelf = self;
    YMLSegmentControl *segmentControl = [[YMLSegmentControl alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 40) titles:titles selectBlock:^(NSInteger index) {
        weakSelf.view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0f];
    }];
    segmentControl.delegate = self;
    [self.view addSubview:segmentControl];
}

#pragma mark -- YMLSegmentControlDelegate
- (void)segmentControl:(YMLSegmentControl *)segmentControl didSelectedAtIndex:(NSInteger)index{
    NSLog(@"click at index : %ld",index);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
