//
// Created by azu on 2013/06/28.
//


#import "FeedbackTableViewController.h"


@implementation FeedbackTableViewController {

}
UIImage *(^createImageFromUIColor)(UIColor *) = ^(UIColor *color) {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(contextRef, [color CGColor]);
    CGContextFillRect(contextRef, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
};

- (void)viewDidLoad {
    [super viewDidLoad];
    // inherit AAMFeedbackViewController
    // initialize setting
    self.backgroundImage = createImageFromUIColor([UIColor colorWithRed:255 / 255.0 green:250 / 255.0 blue:230 / 255.0 alpha:1.0]);
    self.toRecipients = @[@"YOUR_CONTACT@email.com"];
    self.ccRecipients = nil;
    self.bccRecipients = nil;
}

@end