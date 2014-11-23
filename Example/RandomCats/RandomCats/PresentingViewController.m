//
//  PresentingViewController.m
//  WebViewPreloader
//
//  Created by Basar Akyelli on 11/13/13.
//  Copyright (c) 2013 James Lin & Basar Akyelli. All rights reserved.
//

#import "FISWebViewPreloader.h"
#import "PresentingViewController.h"


@interface PresentingViewController ()

@property (strong,nonatomic) FISWebViewPreloader *preloader;
@property (strong,nonatomic) WKWebView *randomWebView;
@end

@implementation PresentingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Presenting View Controller"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)startLoadingButtonPressed:(id)sender {
    
    
    //Creating a Preloader with capacity of 5 WKWebViews.
    self.preloader = [[FISWebViewPreloader alloc] initWithCapacity:5 scheduleType:FIFO];
    
    for(NSInteger i = 0; i<15; i++)
    {
        [self loadWebView:i];
    }
    
}

- (IBAction)fetchRandomSiteButtonPressed:(id)sender {
    
    [self.containerView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    int randomNumber = arc4random_uniform(15);
    self.randomWebView = [self.preloader webViewForKey:[NSNumber numberWithInt:randomNumber]];
    
    [self.containerView addSubview:self.randomWebView];
    
    NSLog(@"priority queue:%@", self.preloader.priorityQueue);

    
}

- (void)loadWebView:(NSInteger)i
{
    NSString *randomURL = [NSString stringWithFormat:
                           @"http://thecatapi.com/api/images/get?format=src&type=png&blah=%i", i];
    
    CGRect cgRect = CGRectMake(0,0,self.containerView.frame.size.width, self.containerView.frame.size.height);
    
    WKWebView *webView = [self.preloader setURLString:randomURL
                                               forKey:[NSNumber numberWithInt:i]
                                           withCGRect:cgRect];
    
    webView.delegate = self;
}

- (void)viewWillLayoutSubviews
{
    
    [self.containerView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    [self.randomWebView setFrame:self.containerView.bounds];
    [self.containerView addSubview:self.randomWebView];
    
}

#pragma mark WKWebViewDelegate methods

- (void)webViewDidStartLoad:(WKWebView *)webView
{
    NSLog(@"Started loading %@", webView.request.URL);
}

- (void)webViewDidFinishLoad:(WKWebView *)webView
{
    NSLog(@"Finished loading %@", webView.request.URL);
}

@end
