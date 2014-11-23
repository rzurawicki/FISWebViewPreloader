#FISWebViewPreloader 
`FISWebViewPreloader` is Cocoapod which helps loading `WKWebView` objects in the background so they can be presented without delays.

---
##Installing FISWebViewPreloader
You can install `FISWebViewPreloader` in your project by using [CocoaPods](https://github.com/cocoapods/cocoapods):

```Ruby
pod 'FISWebViewPreloader'
```

---
##Using FISWebViewPreloader to create pre-loaded `WKWebView` objects 
Using `FISWebViewPreloader` is very easy. We recommend creating a private variable to use `FISWebViewPreloader`:

```Objective-C
@property (strong,nonatomic) FISWebViewPreloader *preloader;

....

self.preloader = [FISWebViewPreloader new];
```

Any time you need to create a pre-loaded `WKWebView` object, you can add your URL string to `FISWebViewPreloader`'s dictionary. 

```Objective-C
[self.preloader setURLString:@"http://www.google.com" forKey:@"Google"];
```

If you need to scale the web pages to fit a certain frame, you can pass the Width and Length values of your frame:

```Objective-C
[self.preloader setURLString:@"http://www.apple.com"
                          forKey:@"Apple"
                      withCGRect:CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height)];
```
---
##Adding Capacity constraint with scheduling
If you are concerned about FISWebViewPreloader to take too much memory, you can define a capacity for the number of `WKWebView`s to be created and pre-loaded. 

```Objective-C
self.preloader = [[FISWebViewPreloader alloc] initWithCapacity:5 scheduleType:FIFO];
```

This will make sure that if more than 5 `WKWebView`s are added, older `WKWebView`s will be removed based on your specified `ScheduleType` (LIFO or FIFO). If you try to access an already-dequeued `WKWebView`, the requested `WKWebView` will be re-created on the fly.

Whenever you access a WKWebView object it will automatically be placed at the head of the priorityQueue.

---
##Accessing your pre-loaded `WKWebView` objects 

There are two ways of accessing the pre-loaded `WKWebView` objects. You can either retrieve your `WKWebView` object at the time of their creation: 

```Objective-C
WKWebView *googleWebView = [self.preloader setURLString:@"http://www.google.com" forKey:@"Google"];
```

Alternatively, you can use `FISWebViewPreloader`'s `webViewForKey:` method: 

```Objective-C
WKWebView *googleWebView = [self.preloader webViewForKey:@"Google"];
````

You can use the following method to access the key for a given `WKWebView`: 

```Objective-C
NSString *myKey = [self.preloader keyForWebView:googleWebView];
//myKey will be @"Google"
```

---
##`WKWebViewDelegate` Protocol: 

If your View Controller adheres to the `WKWebViewDelegate` protocol, then you can use a similar pattern to below to access delegate methods:

```Objective-C

-(void)createWebViews
{
    WKWebView *googleWebView = [self.preloader setURLString:@"http://www.google.com" forKey:@"Google"];
    googleWebView.delegate = self;
}

#pragma mark WKWebViewDelegate methods

- (void)webViewDidStartLoad:(WKWebView *)webView {
    NSLog(@"Started loading %@", [self.preloader keyForWebView:webView]);
}

- (void)webViewDidFinishLoad:(WKWebView *)webView {
    NSLog(@"Finished loading %@", [self.preloader keyForWebView:webView]);
}
```


---
##Removing pre-loaded `WKWebView` objects

You can call the `removeWebViewForKey:` method to stop the destroy any `WKWebView` objects that you no longer need: 

```Objective-C
[self.preloader removeWebViewForKey:@"Google"];
```

You can also call the `reset:` method to destroy all key/object pairs in the preloader and the priorityQueue: 

```Objective-C
[self.preloader reset];
```


