//
// Created by azu on 2013/10/30.
//


#import <Foundation/Foundation.h>


@interface AcceptanceTestHelper : NSObject
+ (UINavigationController *)instantiateInitialViewController;

+ (UIViewController *)viewControllerWithStoryBoardID:(NSString *) storyBoardId;

+ (void)presentViewController:(UIViewController *) viewController;

+ (void)setRootViewController:(UIViewController *) viewController;
@end