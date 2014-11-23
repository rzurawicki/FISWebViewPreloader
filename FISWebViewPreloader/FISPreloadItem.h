#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface FISPreloadItem : NSObject

@property (strong, nonatomic) NSString *URLString;
@property (strong, nonatomic) WKWebView *webView;
@property (assign) CGRect cgRect;

- (id)initWithURLString:(NSString *)aURLString
             withCGRect:(CGRect)cgRect;

- (void)loadWebView;
- (void)unloadWebView;

@end
