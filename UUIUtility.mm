#import "UUIUtility.h"


UIButton * UIUGetUIButton(CGRect frame, NSString * title, id target, SEL action)
{
    UIButton * btn = nil;
    [btn = [UIButton buttonWithType: UIButtonTypeRoundedRect] 
     addTarget:target action:action forControlEvents: UIControlEventTouchUpInside];
    [btn setFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    
    return btn;
}


UILabel * UIUGetUILabel(NSString * title)
{
    CGRect r = [[UIScreen mainScreen] applicationFrame];
    r.origin.x = r.size.width * 0.2;
    r.origin.y = r.size.height * 0.2;
    r.size.width = r.size.width * 0.4;
    r.size.height = r.size.height * 0.2;
    
    UILabel * lab = [[UILabel alloc] initWithFrame:r];
    lab.text = title;
    return [lab autorelease];
}


UIWindow * UIUGetMainWindow()
{
    return [[UIApplication sharedApplication] keyWindow];
}

BOOL UIUDeviceIsBackgroundSupported()
{
    static BOOL backgroundSupported = NO; 
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^
                  {
                      UIDevice* device = [UIDevice currentDevice];
                      if ([device respondsToSelector:@selector(isMultitaskingSupported)])
                          backgroundSupported = device.multitaskingSupported;
                  });
    
    return backgroundSupported;
}



@implementation UINavigationController(_flipAnimation_)

static void (^ g_block4flipAnimation4Nav)(void) = NULL;

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if(g_block4flipAnimation4Nav)
    {
        g_block4flipAnimation4Nav();
        g_block4flipAnimation4Nav = NULL;
    }
}

- (void)pushAnimationViewController:(UIViewController *)vc
                     withTransition:(UIViewAnimationTransition)transition
                    completionBlock:(void (^)(void))block
{    
    UIViewController * oldViewController = [[self.topViewController retain] autorelease];
    [self pushViewController:vc animated:NO];
    
    UIView * oldView;
    if(oldViewController.tabBarController)
        oldView = oldViewController.tabBarController.view;
    else if(oldViewController.navigationController)
        oldView = oldViewController.navigationController.view;
    else 
        oldView = oldViewController.view;
        
    [UIView beginAnimations:@"__FlipAnimationForNav" context:NULL];  
    [UIView setAnimationDuration:.7];  
    [UIView setAnimationTransition:transition
                           forView:oldView cache:YES];  
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    g_block4flipAnimation4Nav = block;
    [UIView commitAnimations];
}

- (void)popAnimationViewControllerWithTransition:(UIViewAnimationTransition)transition
                                 completionBlock:(void (^)(void))block
{
    UIViewController * oldViewController = [[self.topViewController retain] autorelease];
    
    UIView * oldView;
    if(oldViewController.tabBarController)
        oldView = oldViewController.tabBarController.view;
    else if(oldViewController.navigationController)
        oldView = oldViewController.navigationController.view;
    else 
        oldView = oldViewController.view;
    
    [UIView beginAnimations:@"__FlipAnimationForNav" context:NULL];  
    [UIView setAnimationDuration:.7];  
    [UIView setAnimationTransition:transition
                           forView:oldView cache:YES];  
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    g_block4flipAnimation4Nav = block;
    [UIView commitAnimations];    
    
    [self popViewControllerAnimated:NO];//悟性!
}

@end


@implementation UIWebView(_UIU_)

- (int)scrollPosition
{
    return [[self stringByEvaluatingJavaScriptFromString:@"window.pageYOffset"] intValue];
}

- (void)scrollToYPosition:(int)y
{
    [self stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"window.scrollBy(0,%d);", y]];
}

- (int)sizePage
{
    return [[self stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"foo\").offsetHeight;"] intValue];
}

@end


@implementation UITabBarController(_UIU_)

- (void)makeTabBarHidden:(BOOL)hide
{
    if ( [self.view.subviews count] < 2 )
    {
        return;
    }
    UIView *contentView;
    if ( [[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
    {
        contentView = [self.view.subviews objectAtIndex:1];
    }
    else
    {
        contentView = [self.view.subviews objectAtIndex:0];
    }
    if ( hide )
    {
        contentView.frame = self.view.bounds;        
    }
    else
    {
        contentView.frame = CGRectMake(self.view.bounds.origin.x,
                                       self.view.bounds.origin.y,
                                       self.view.bounds.size.width,
                                       self.view.bounds.size.height - self.tabBar.frame.size.height);
    }
    self.tabBar.hidden = hide; 
}

- (BOOL)hasMakeTabBarHiddened
{
    if ( [self.view.subviews count] < 2 )
    {
        return NO;
    }
    UIView *contentView;
    if ( [[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
    {
        contentView = [self.view.subviews objectAtIndex:1];
    }
    else
    {
        contentView = [self.view.subviews objectAtIndex:0];
    }
    return contentView.frame.size.height == self.view.bounds.size.height;
}

@end


@implementation NSDate(_UIU_)

+ (NSDate *)todayZero
{
    NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
    NSCalendar *calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDate * today = [NSDate date];
    int y, m, d;
    [today parseOutYear:&y month:&m day:&d week:NULL hour:NULL min:NULL sec:NULL];
    comps.year = y;
    comps.month = m;
    comps.day = d;
    return [calendar dateFromComponents:comps];
}

- (void)parseOutYear:(int *)pYear month:(int *)pMonth day:(int *)pDay week:(int *)pWeek
                hour:(int *)pHour min:(int *)pMin sec:(int *)pSec
{
    NSDateFormatter *formatter =[[[NSDateFormatter alloc] init] autorelease];
    NSDate *date = self;
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    if(pYear)
        *pYear = [comps year];
    if(pMonth)
        *pMonth = [comps month];
    if(pDay)
        *pDay = [comps day];
    if(pWeek)
        *pWeek = [comps weekday];
    if(pHour)
        *pHour = [comps hour];
    if(pMin)
        *pMin = [comps minute];
    if(pSec)
        *pSec = [comps second];
}

@end












