//
//  AAMFeedbackViewController.m
//  AAMFeedbackViewController
//
//  Created by 深津 貴之 on 11/11/30.
//  Copyright (c) 2011年 Art & Mobile. All rights reserved.
//

#import "AAMFeedbackViewController.h"
#import "AAMFeedbackTopicsViewController.h"
#import "UIDeviceHardware.h"

// Localizable bundle
static BOOL _alwaysUseMainBundle = NO;

@interface AAMFeedbackViewController ()

@property(nonatomic, strong) UITextView *descriptionTextView;

@property(nonatomic, strong) UILabel *descriptionPlaceHolder;

@property(nonatomic) BOOL isFeedbackSent;

- (NSString *)_platformString;

- (NSString *)_feedbackSubject;

- (NSString *)_feedbackBody;

- (NSString *)_appName;

- (NSString *)_appVersion;

- (NSString *)_selectedTopic;

- (NSString *)_selectedTopicToSend;

- (void)_updatePlaceholder;
@end


@implementation AAMFeedbackViewController

+ (BOOL)isAvailable {
    return [MFMailComposeViewController canSendMail];
}

- (id)initWithStyle:(UITableViewStyle) style {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self == nil) {
        return nil;
    }
    return self;
}

- (id)initWithTopics:(NSArray *) theIssues {
    self = [self init];
    if (self) {
        self.topics = theIssues;
        self.topicsToSend = theIssues;
    }
    return self;
}

+ (void)setAlwaysUseMainBundle:(BOOL) alwaysUseMainBundle {
    _alwaysUseMainBundle = alwaysUseMainBundle;
}

+ (NSBundle *)bundle {
    NSBundle *bundle;
    if (_alwaysUseMainBundle) {
        bundle = [NSBundle mainBundle];
    } else {
        NSURL *bundleURL = [[NSBundle bundleForClass:self.class] URLForResource:@"AAMFeedback" withExtension:@"bundle"];
        if (bundleURL) {
            // AAMFeedback.bundle will likely only exist when used via CocoaPods
            bundle = [NSBundle bundleWithURL:bundleURL];
        } else {
            bundle = [NSBundle mainBundle];
        }
    }

    return bundle;
}

- (NSBundle *)applicationBundle {
    if (!_applicationBundle) {
        _applicationBundle = [NSBundle mainBundle];
    }
    return _applicationBundle;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedStringFromTableInBundle(@"AAMFeedbackTitle", @"AAMLocalizable", [AAMFeedbackViewController bundle], nil);
    if (self.topics == nil) {
        self.topics = @[
            NSLocalizedStringFromTableInBundle(@"AAMFeedbackTopicsQuestion", @"AAMLocalizable", [AAMFeedbackViewController bundle], nil),
            NSLocalizedStringFromTableInBundle(@"AAMFeedbackTopicsRequest", @"AAMLocalizable", [AAMFeedbackViewController bundle], nil),
            NSLocalizedStringFromTableInBundle(@"AAMFeedbackTopicsBugReport", @"AAMLocalizable", [AAMFeedbackViewController bundle], nil),
            NSLocalizedStringFromTableInBundle(@"AAMFeedbackTopicsMedia", @"AAMLocalizable", [AAMFeedbackViewController bundle], nil),
            NSLocalizedStringFromTableInBundle(@"AAMFeedbackTopicsBusiness", @"AAMLocalizable", [AAMFeedbackViewController bundle], nil),
            NSLocalizedStringFromTableInBundle(@"AAMFeedbackTopicsOther", @"AAMLocalizable", [AAMFeedbackViewController bundle], nil)
        ];
    }

    self.topicsToSend = [self.topics copy];
    [self updateBackGroundImage];
}

- (void)setBackgroundImage:(UIImage *) backgroundImage {
    _backgroundImage = backgroundImage;
    if ([self isViewLoaded]) {
        [self updateBackGroundImage];
    }
}

- (void)updateBackGroundImage {
    if (self.backgroundImage != nil) {
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:self.backgroundImage];
        self.tableView.backgroundView = backgroundImageView;
    }
}


- (void)viewDidUnload {
    [super viewDidUnload];
    self.descriptionPlaceHolder = nil;
    self.descriptionTextView = nil;
}

- (void)viewWillAppear:(BOOL) animated {
    [super viewWillAppear:animated];
    [self _updateNavigation];
    [self _updatePlaceholder];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL) animated {
    [super viewDidAppear:animated];
    if (self.isFeedbackSent) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)viewWillDisappear:(BOOL) animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL) animated {
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *) tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger) section {
    if (section == 0) {
        return 2;
    }
    return 4;
}

- (CGFloat)tableView:(UITableView *) tableView heightForRowAtIndexPath:(NSIndexPath *) indexPath {
    if (indexPath.section == 0 && indexPath.row == 1) {
        return MAX(88, [self contentSizeOfTextView:self.descriptionTextView].height);
    }

    return 44;
}

- (NSString *)tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger) section {
    switch (section) {
        case 0:
            return NSLocalizedStringFromTableInBundle(@"AAMFeedbackTableHeaderTopics", @"AAMLocalizable", [AAMFeedbackViewController bundle], nil);
        case 1:
            return NSLocalizedStringFromTableInBundle(@"AAMFeedbackTableHeaderBasicInfo", @"AAMLocalizable", [AAMFeedbackViewController bundle], nil);
        default:
            break;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath {
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        if (indexPath.section == 1) {
            //General Infos
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        } else {
            if (indexPath.row == 0) {
                //Topics
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            } else {
                //Topics Description
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                NSInteger textViewMargin = 10;
                self.descriptionTextView = [[UITextView alloc] initWithFrame:CGRectInset(cell.contentView.frame, textViewMargin, 0)];
                self.descriptionTextView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
                self.descriptionTextView.backgroundColor = [UIColor clearColor];
                self.descriptionTextView.font = [UIFont systemFontOfSize:16];
                self.descriptionTextView.delegate = self;
                self.descriptionTextView.scrollEnabled = NO;
                self.descriptionTextView.text = self.descriptionText;
                [cell.contentView addSubview:self.descriptionTextView];

                self.descriptionPlaceHolder = [[UILabel alloc] initWithFrame:CGRectInset(cell.contentView.frame, textViewMargin, 5)];
                self.descriptionPlaceHolder.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
                self.descriptionPlaceHolder.font = [UIFont systemFontOfSize:16];
                self.descriptionPlaceHolder.text = NSLocalizedStringFromTableInBundle(@"AAMFeedbackDescriptionPlaceholder", @"AAMLocalizable", [AAMFeedbackViewController bundle], nil);
                self.descriptionPlaceHolder.textColor = [UIColor lightGrayColor];
                self.descriptionPlaceHolder.numberOfLines = 0;
                self.descriptionPlaceHolder.userInteractionEnabled = NO;
                [cell.contentView addSubview:self.descriptionPlaceHolder];
                [self.descriptionPlaceHolder sizeToFit];

                [self _updatePlaceholder];
            }
        }
    }

    // Configure the cell...
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:

                    cell.textLabel.text = NSLocalizedStringFromTableInBundle(@"AAMFeedbackTopicsTitle", @"AAMLocalizable", [AAMFeedbackViewController bundle], nil);
                    cell.detailTextLabel.text = NSLocalizedStringFromTableInBundle([self _selectedTopic], @"AAMLocalizable", [AAMFeedbackViewController bundle], nil);
                    break;
                case 1:
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"Device";
                    cell.detailTextLabel.text = [self _platformString];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    break;
                case 1:
                    cell.textLabel.text = @"iOS";
                    cell.detailTextLabel.text = [UIDevice currentDevice].systemVersion;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    break;
                case 2:
                    cell.textLabel.text = @"App Name";
                    cell.detailTextLabel.text = [self _appName];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    break;
                case 3:
                    cell.textLabel.text = @"App Version";
                    cell.detailTextLabel.text = [self _appVersion];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }

    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self.descriptionTextView resignFirstResponder];
        AAMFeedbackTopicsViewController *topicsViewController = [[AAMFeedbackTopicsViewController alloc] initWithStyle:UITableViewStyleGrouped];
        if (self.backgroundImage != nil) {
            UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:self.backgroundImage];
            topicsViewController.tableView.backgroundView = backgroundImageView;
        }
        if (self.view.backgroundColor != nil) {
            topicsViewController.view.backgroundColor = self.view.backgroundColor;
        }
        topicsViewController.topics = [self.topics copy];
        topicsViewController.delegate = self;
        topicsViewController.selectedIndex = _selectedTopicsIndex;
        [self.navigationController pushViewController:topicsViewController animated:YES];
    }
}


- (void)cancelDidPress:(id) sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)nextDidPress:(id) sender {
    [self.descriptionTextView resignFirstResponder];
    if (![[self class] isAvailable]) {
        return;
    }
    MFMailComposeViewController *mailComposeViewController = [[MFMailComposeViewController alloc] init];
    mailComposeViewController.mailComposeDelegate = self;
    [mailComposeViewController setToRecipients:self.toRecipients];
    [mailComposeViewController setCcRecipients:self.ccRecipients];
    [mailComposeViewController setBccRecipients:self.bccRecipients];
    [mailComposeViewController setSubject:[self _feedbackSubject]];
    [mailComposeViewController setMessageBody:[self _feedbackBody] isHTML:NO];
    if (self.beforeShowAction) {
        self.beforeShowAction(mailComposeViewController);
    }
    [self presentViewController:mailComposeViewController animated:YES completion:nil];
}


- (void)textViewDidChange:(UITextView *) textView {
    //Magic for updating Cell height
    [self.tableView beginUpdates];
    [self.tableView endUpdates];

    CGRect f = self.descriptionTextView.frame;
    f.size.height = [self contentSizeOfTextView:self.descriptionTextView].height;
    self.descriptionTextView.frame = f;
    [self _updatePlaceholder];
    self.descriptionText = self.descriptionTextView.text;

}

- (CGSize)contentSizeOfTextView:(UITextView *) myTextView {
    return [myTextView sizeThatFits:CGSizeMake(myTextView.frame.size.width, FLT_MAX)];
}

- (void)mailComposeController:(MFMailComposeViewController *) controller
          didFinishWithResult:(MFMailComposeResult) result error:(NSError *) error {
    if (result == MFMailComposeResultCancelled) {
    } else if (result == MFMailComposeResultSent) {
        self.isFeedbackSent = YES;
    } else if (result == MFMailComposeResultFailed) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedStringFromTableInBundle(@"AAMFeedbackMailDidFinishWithError", @"AAMLocalizable", [AAMFeedbackViewController bundle], nil)
                                                                    delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}


- (void)feedbackTopicsViewController:(AAMFeedbackTopicsViewController *) feedbackTopicsViewController
               didSelectTopicAtIndex:(NSInteger) selectedIndex {
    _selectedTopicsIndex = selectedIndex;
}

#pragma mark - Internal Info

// http://stackoverflow.com/questions/2798653/is-it-possible-to-determine-whether-viewcontroller-is-presented-as-modal
- (BOOL)isModal {
    BOOL isModal = ((self.parentViewController && self.parentViewController.presentedViewController == self) ||
        //or if I have a navigation controller, check if its parent modal view controller is self navigation controller
            (self.navigationController && self.navigationController.parentViewController && self.navigationController.parentViewController.presentedViewController == self.navigationController) ||
        //or if the parent of my UITabBarController is also a UITabBarController class, then there is no way to do that, except by using a modal presentation
            [[[self tabBarController] parentViewController] isKindOfClass:[UITabBarController class]]);

    //iOS 5+
    if (!isModal && [self respondsToSelector:@selector(presentingViewController)]) {
        isModal = ((self.presentingViewController && self.presentingViewController.presentedViewController == self) ||
            //or if I have a navigation controller, check if its parent modal view controller is self navigation controller
                (self.navigationController && self.navigationController.presentingViewController && self.navigationController.presentingViewController.presentedViewController == self.navigationController) ||
            //or if the parent of my UITabBarController is also a UITabBarController class, then there is no way to do that, except by using a modal presentation
                [[[self tabBarController] presentingViewController] isKindOfClass:[UITabBarController class]]);

    }
    return isModal;
}

- (void)_updateNavigation {
    if ([self isModal]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelDidPress:)];
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTableInBundle(@"AAMFeedbackButtonMail", @"AAMLocalizable", [AAMFeedbackViewController bundle], nil) style:UIBarButtonItemStyleDone target:self action:@selector(nextDidPress:)];
}

- (void)_updatePlaceholder {
    if ([self.descriptionTextView.text length] > 0) {
        self.descriptionPlaceHolder.hidden = YES;
    } else {
        self.descriptionPlaceHolder.hidden = NO;
    }
}

- (NSString *)_feedbackSubject {
    return [NSString stringWithFormat:@"%@: %@", [self _appName], [self _selectedTopicToSend]];
}

- (NSString *)_feedbackBody {
    NSString *body = [NSString stringWithFormat:@"%@\n\n\nDevice:\n%@\n\niOS:\n%@\n\nApp:\n%@ %@",
                                                self.descriptionTextView.text,
                                                [self _platformString],
                                                [UIDevice currentDevice].systemVersion,
                                                [self _appName],
                                                [self _appVersion]];

    return body;
}

- (NSString *)_selectedTopic {
    return (self.topics)[(NSUInteger)_selectedTopicsIndex];
}

- (NSString *)_selectedTopicToSend {
    return (self.topicsToSend)[(NSUInteger)_selectedTopicsIndex];
}

- (NSString *)_appName {
    NSDictionary *info = [self.applicationBundle infoDictionary];
    return info[@"CFBundleDisplayName"] ?: info[@"CFBundleName"];
}

- (NSString *)_appVersion {
    return [self.applicationBundle infoDictionary][@"CFBundleVersion"];
}


- (NSString *)_platformString {
    return [UIDeviceHardware platformString];
}

@end
