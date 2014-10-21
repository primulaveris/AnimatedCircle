//
//  ViewController.m
//  AnimationFun
//
//  Created by Marian O'Shea on 10/10/2014.
//  Copyright (c) 2014 Marian O'Shea. All rights reserved..
//

#import "ViewController.h"
#import "CircleView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
  //   [ self.wheelView drawCircle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)drawCircle1:(id)sender {
    [self.circleView drawCircleAnimated];
}

- (IBAction)pause:(id)sender {
    [self.circleView pauseAnimation];
}

- (IBAction)resume:(id)sender {
    [self.circleView resumeAnimation];
}
@end
