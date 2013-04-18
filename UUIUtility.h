/**
 * @file UUIUtility.h
 * @brief 快捷UI获取等辅助工具.
 * @author hUyIncHun
 * @date 2012
 * @version 2.36
 * @par 修改记录：
 *  -2.34:修改nav的push动画方法名.
 *  -2.3:增加category方法.
 *  -2.2:增加nav的push和pop的翻转动画函数.(未经严格测验，仅保证在tab嵌nav的状况下无误.)
 *  -2.0:加函数.
 *  -1.9:增加高清设备的判断.
 *  -1.5:改函数名首大写.
 *  -1.2:fix a bug about UIUGetMainWindow.
 */

/**************************************************/
#ifndef _UUIUtility_h_
#define _UUIUtility_h_
/**************************************************/


#import <UIKit/UIKit.h>



CG_EXTERN UIButton * UIUGetUIButton(CGRect frame, NSString * title, id target, SEL action);

CG_EXTERN UILabel * UIUGetUILabel(NSString * title);

CG_EXTERN UIWindow * UIUGetMainWindow();

CG_EXTERN BOOL UIUDeviceIsBackgroundSupported();


///useful macro define
//
#define UIU_IsIPad    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define UIU_IsRetina    ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] == YES && [[UIScreen mainScreen] scale] == 2.00)

#define UIU_IsIOS4      ([[[UIDevice currentDevice] systemVersion] intValue] < 5)
#define UIU_IsIOS5      ([[[UIDevice currentDevice] systemVersion] intValue] == 5)
#define UIU_IsIOSLT5    UIU_IsIOS4  /* ps: 'LT' mean 'less than'; 'GT' mean 'greater than'; 'GE' mean 'greater equal'. */
#define UIU_IsIOSGE5    ([[[UIDevice currentDevice] systemVersion] intValue] >= 5)
#define UIU_IsIOSGT5    ([[[UIDevice currentDevice] systemVersion] intValue] > 5)
#define UIU_IsIOS6      ([[[UIDevice currentDevice] systemVersion] intValue] == 6)
#define UIU_IsIOSLT6    ([[[UIDevice currentDevice] systemVersion] intValue] < 6)
#define UIU_IsIOSGE6    UIU_IsIOSGT5


///Navigation
//
@interface UINavigationController(_flipAnimation_)
- (void)pushAnimationViewController:(UIViewController *)vc
                     withTransition:(UIViewAnimationTransition)transition
                    completionBlock:(void (^)(void))block;
- (void)popAnimationViewControllerWithTransition:(UIViewAnimationTransition)transition
                                 completionBlock:(void (^)(void))block;
@end


///WebView
//
@interface UIWebView(_UIU_)
- (int)scrollPosition;
- (void)scrollToYPosition:(int)y;
- (int)sizePage;
@end


///tabBarController
//
@interface UITabBarController(_UIU_)
- (void)makeTabBarHidden:(BOOL)hide;
- (BOOL)hasMakeTabBarHiddened;
@end


///date
//
@interface NSDate(_UIU_)
+ (NSDate *)todayZero;/**< 获取今日零点的NSDate. */
- (void)parseOutYear:(int *)pYear month:(int *)pMonth day:(int *)pDay week:(int *)pWeek
                hour:(int *)pHour min:(int *)pMin sec:(int *)pSec;
@end

/**************************************************/
#endif // _UUIUtility_h_


