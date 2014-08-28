# AAMFeedback

Simple Feedback library, forked from [fladdict/AAMFeedback](https://github.com/fladdict/AAMFeedback "fladdict/AAMFeedback").

![screenshot](http://f.cl.ly/items/291A0A2u0R2B3u3V0b3H/screenshot.png)

## Installation

	pod 'AAMFeedback', :git => 'https://github.com/azu/AAMFeedback.git'

## Usage

See Example

``` objc
AAMFeedbackViewController *feedbackViewController = [[AAMFeedbackViewController alloc] init];
feedbackViewController.toRecipients = @[@"YOUR_CONTACT@email.com"];
feedbackViewController.ccRecipients = nil;
feedbackViewController.bccRecipients = nil;
UINavigationController *feedbackNavigation = [[UINavigationController alloc] initWithRootViewController:feedbackViewController];
[self presentViewController:feedbackNavigation animated:YES completion:nil];
```

AAMFeedbackViewController is a UITableViewController Subclass.
You can use setting `AAMFeedbackViewController` to the view controller's custom class in storyboard.

For details, See ``FeedbackTableViewController`` of Example.

### Custom Localization

When using AAMFeedback via CocoaPods, you should following setting to custom localization.

```objc
[AAMFeedbackViewController setAlwaysUseMainBundle:YES];
```

You’ll need to manually create/copy AAMLocalizable.strings to your project.

Example project:

* [azu/AAMFeedbackLocalizeExample](https://github.com/azu/AAMFeedbackLocalizeExample "azu/AAMFeedbackLocalizeExample")

Thanks [Move lproj directories to Appirater.bundle when using CocoaPods by eager · Pull Request #129 · arashpayan/appirater](https://github.com/arashpayan/appirater/pull/129 "Move lproj directories to Appirater.bundle when using CocoaPods by eager · Pull Request #129 · arashpayan/appirater").

## Difference from original [fladdict/AAMFeedback](https://github.com/fladdict/AAMFeedback "fladdict/AAMFeedback")

* **ARC** ed.
* Device information is defined by the use of [squarefrog/UIDeviceIdentifier](https://github.com/squarefrog/UIDeviceIdentifier "squarefrog/UIDeviceIdentifier").
* Custom BackgroundImage/Topics/Localized.string
* Added spanish locale.(thanks @ericertl)

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## License

New BSD License
