//
// Created by azu on 2013/10/30.
//


#import "AcceptanceTestHelper.h"


@implementation AcceptanceTestHelper {

}
+ (UINavigationController *)instantiateInitialViewController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateInitialViewController];
}

+ (UIViewController *)viewControllerWithStoryBoardID:(NSString *) storyBoardId {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:storyBoardId];
}

+ (void)presentViewController:(UIViewController *) viewController {
    UIViewController *root = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    [root.presentedViewController dismissViewControllerAnimated:NO completion:nil];
    [root presentViewController:viewController animated:NO completion:nil];
}

+ (void)setRootViewController:(UIViewController *) viewController {
    [[[UIApplication sharedApplication] keyWindow] setRootViewController:viewController];
}


@end