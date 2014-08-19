//
//  ViewController.m
//  AsyncTestingApp
//
//  Created by David C. Thömmes on 10.08.14.
//  Copyright (c) 2014 dct. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)downloadPressed
{
    [[Service sharedService] downloadRSSWithCompletionBlock:^(BOOL success, NSString* result)
    {
        if (success)
            NSLog(@"Download result > %@", result);
        else
            NSLog(@"Download failed!");
    }];
}

@end
