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

- (void)pushFlipAnimationViewController:(UIViewController *)vc
                    withCompletionBlock:(void (^)(void))block
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
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft   
                           forView:oldView cache:YES];  
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    g_block4flipAnimation4Nav = block;
    [UIView commitAnimations];
}

- (void)popFlipAnimationViewControllerWithCompletionBlock:(void (^)(void))block
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
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight  
                           forView:oldView cache:YES];  
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    g_block4flipAnimation4Nav = block;
    [UIView commitAnimations];    
    
    [self popViewControllerAnimated:NO];//悟性!
}

@end




















