//
//  ViewController.m
//  ImageScrollManger
//
//  Created by Miller on 2018/5/30.
//  Copyright © 2018年 Miller. All rights reserved.
//

#import "ViewController.h"
#import "GJNewsImageScrollViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)imageClicked:(UIButton *)sender {
    [self presentViewController:[[GJNewsImageScrollViewController alloc] init] animated:YES completion:nil];
}

@end
