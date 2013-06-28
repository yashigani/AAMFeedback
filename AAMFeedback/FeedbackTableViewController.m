//
// Created by azu on 2013/06/28.
//


#import "FeedbackTableViewController.h"


@implementation FeedbackTableViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // inherit AAMFeedbackViewController
    // initialize setting
    self.toRecipients = [NSArray arrayWithObject:@"YOUR_CONTACT@email.com"];
    self.ccRecipients = nil;
    self.bccRecipients = nil;
}

@end