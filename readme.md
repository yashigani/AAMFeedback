# AAMFeedback

Simple Feedback library

![screenshot](http://take.ms/Z8EJCz)

## Installation


	pod 'AAMFeedback', :podspec => 'https://raw.github.com/azu/AAMFeedback/master/AAMFeedback.podspec'


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

also able to UITableViewController Subclass

see ``FeedbackTableViewController`` 

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## License

New BSD License