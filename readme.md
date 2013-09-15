# AAMFeedback

Simple Feedback library, forked form [fladdict/AAMFeedback](https://github.com/fladdict/AAMFeedback "fladdict/AAMFeedback").

![screenshot](http://f.cl.ly/items/291A0A2u0R2B3u3V0b3H/screenshot.png)

## Installation

	pod 'AAMFeedback', :git => 'https://github.com/azu/AAMFeedback.git'

You should use ">= Cocoapods 0.24.0".

## Usage

See Sample

``` objc
AAMFeedbackViewController *vc = [[AAMFeedbackViewController alloc] init];
vc.toRecipients = @[@"YOUR_CONTACT@email.com"];
vc.ccRecipients = nil;
vc.bccRecipients = nil;
UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
[self presentModalViewController:nvc animated:YES];
```

also be able to UITableViewController Subclass.

See ``FeedbackTableViewController`` for details.


### Custom Localize

When using AAMFeedback via CocoaPods, you should following setting to custom localization.

```objc
[AAMFeedbackViewController setAlwaysUseMainBundle:YES];
```

You’ll need to manually create/copy AAMLocalizable.strings to your project.

Example project:

* [azu/AAMFeedbackLocalizeExample](https://github.com/azu/AAMFeedbackLocalizeExample "azu/AAMFeedbackLocalizeExample")

Thanks [Move lproj directories to Appirater.bundle when using CocoaPods by eager · Pull Request #129 · arashpayan/appirater](https://github.com/arashpayan/appirater/pull/129 "Move lproj directories to Appirater.bundle when using CocoaPods by eager · Pull Request #129 · arashpayan/appirater").

## Difference from original [fladdict/AAMFeedback](https://github.com/fladdict/AAMFeedback "fladdict/AAMFeedback")

* **ARC**ed.
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
