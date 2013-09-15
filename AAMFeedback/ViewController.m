//
//  ViewController.m
//  AAMFeedbackViewController
//
//  Created by 深津 貴之 on 11/11/30.
//  Copyright (c) 2011年 Art & Mobile. All rights reserved.
//

#import "ViewController.h"
#import "AAMFeedbackViewController.h"

@implementation ViewController


- (IBAction)handleOpenAsModal:(id) sender {
    AAMFeedbackViewController *vc = [[AAMFeedbackViewController alloc] init];
    vc.toRecipients = @[@"YOUR_CONTACT@email.com"];
    vc.ccRecipients = nil;
    vc.bccRecipients = nil;
    UINavigationController *feedbackNavigation = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:feedbackNavigation animated:YES completion:nil];
}
@end
