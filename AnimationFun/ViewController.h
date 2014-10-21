//
//  ViewController.h
//  AnimationFun
//
//  Created by Marian O'Shea on 10/10/2014.
//  Copyright (c) 2014 Marian O'Shea. All rights reserved..
//

#import <UIKit/UIKit.h>

@class CircleView; 

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet CircleView *circleView;

- (IBAction)drawCircle1:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)resume:(id)sender;

@end

