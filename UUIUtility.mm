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