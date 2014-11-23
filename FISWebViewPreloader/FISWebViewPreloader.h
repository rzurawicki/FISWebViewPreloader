#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

/** The `FISWebViewPrelaoder` class manages the execution of preloading of `WKWebView` objects. 
 * User can add `WKWebView` objects using its public methods and the added views will be preloaded.  
 *
 * By default, it accepts an unlimited amount of `WKWebView` objects for preloading. It also supports 
 * limiting the `WKWebView` capacity for memory management concerns. 
 */
@interface FISWebViewPreloader : NSObject

/**-----------------------------------------------------------------------------
 * @name ScheduleType enumaration for scheduling of `WKWebView` objects
 * -----------------------------------------------------------------------------
 */

 /** Lets the user define the schedule of `WKWebView` objects to be removed when capacity is reached. */
typedef enum {
    FIFO,
    LIFO
} ScheduleType;


/**-----------------------------------------------------------------------------
 * @name Initializing 
 * -----------------------------------------------------------------------------
 */

 /**Internal queue to determine which `WKWebView` to remove if the capacity is reached. */
@property (strong, nonatomic) NSMutableArray *priorityQueue;

/**Initalizer which accepts capacity and ScheduleType parameters. */
- (id)initWithCapacity:(NSInteger)capacity scheduleType:(ScheduleType)schedule;

/**-----------------------------------------------------------------------------
 * @name Adding, removing and retrieving `WKWebView` objects. 
 * -----------------------------------------------------------------------------
 */

 /**Add `WKWebView` for preloading with `CGRect` definition
  *
  * @param aURLString The URL string for the `WKWebView`
  * @param aKey Key to identify the `WKWebView`
  * @param cgRect `CGRect` definition for the `WKWebView`
  **/
- (WKWebView *)setURLString:(NSString *)aURLString forKey:(id<NSCopying>)aKey withCGRect:(CGRect)cgRect;

/**Add 'WKWebView' for preloading
 *
 * @param aURLString The URL string for the `WKWebView`
 * @param aKey Key to identify the `WKWebView`
 */
- (WKWebView *)setURLString:(NSString *)aURLString forKey:(id<NSCopying>)aKey;

/**Retrieve preloaded `WKWebView`
 *
 *@param aKey Key to identify the requested `WKWebView`
 */
- (WKWebView *)webViewForKey:(id<NSCopying>)aKey;

/**Removes a `WKWebView` from queue. 
 *
 *@param aKey Key to identify the `WKWebView` to unload. 
 */
- (void)unloadWebViewForKey:(id<NSCopying>)aKey;

/**Returns all stored keys for preloaded `WKWebView` ojbects.*/
- (NSArray *)allKeys;

/**Removes all preloaded `WKWebView` objects.*/
- (void)reset;

@end
