//
// Created by azu on 2013/10/30.
//


#import "KIFTestCase.h"
#import "KIFUITestActor.h"
#import "AcceptanceTestHelper.h"
#import "AAMFeedbackViewController.h"

@interface OpenViewControllerTests : KIFTestCase
@end

@implementation OpenViewControllerTests {
    AAMFeedbackViewController *feedbackViewController;
}

- (void)beforeEach {
    feedbackViewController = [[AAMFeedbackViewController alloc] init];
}

- (void)testOpenAsModal {
    UINavigationController *topNavigation = [AcceptanceTestHelper instantiateInitialViewController];
    [AcceptanceTestHelper setRootViewController:topNavigation];

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:feedbackViewController];
    [AcceptanceTestHelper presentViewController:navigationController];

    [tester tapViewWithAccessibilityLabel:@"Cancel"];
    [tester waitForViewWithAccessibilityLabel:[topNavigation.topViewController.view accessibilityLabel]];
}

- (void)testOpenAsPush {
    UINavigationController *topNavigation = [AcceptanceTestHelper instantiateInitialViewController];
    [AcceptanceTestHelper setRootViewController:topNavigation];

    [topNavigation pushViewController:feedbackViewController animated:YES];

    [tester tapViewWithAccessibilityLabel:@"Back"];

    [tester waitForViewWithAccessibilityLabel:[topNavigation.topViewController.view accessibilityLabel]];
}

@end
