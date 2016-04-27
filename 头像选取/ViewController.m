//
//  ViewController.m
//  头像选取
//
//  Created by 李志鹏 on 16/4/27.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blueColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 79, 40)];
    [btn setTitle:@"头像选取" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: btn];
}

-(void)btnClick
{
    UzysAssetsPickerController *picker = [[UzysAssetsPickerController alloc] init];
    picker.delegate = self;
    picker.maximumNumberOfSelectionPhoto = 1;
    picker.maximumNumberOfSelectionVideo = 0;
    [self presentViewController:picker animated:YES completion:nil];
    //[self.navigationController pushViewController:picker animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
