

#include "UDebug.h"

#ifdef UDebug

#import <objc/objc.h>
#import <objc/runtime.h>
#import <objc/message.h>

void __UDInfoClass(Class cla)
{
    unsigned int count;
    Method * methods = class_copyMethodList(cla, &count);
    NSLog(@"%@'s methods:", NSStringFromClass(cla));
    for(int i = 0; i != count; i++)
    {
        NSLog(@"%@", NSStringFromSelector(method_getName(methods[i])));
    }
    free(methods);
    
    objc_property_t * propertys = class_copyPropertyList(cla, &count);
    NSLog(@"%@'s Propertys:", NSStringFromClass(cla));
    for(int i = 0; i != count; i++)
    {
        NSLog(@"%s", property_getName(propertys[i]));
    }
    free(propertys);
    
    Ivar * ivars = class_copyIvarList(cla, &count);
    NSLog(@"%@'s Ivars:", NSStringFromClass(cla));
    for(int i = 0; i != count; i++)
    {
        NSLog(@"%s:%s", ivar_getName(ivars[i]), ivar_getTypeEncoding(ivars[i]));
    }
    free(ivars);
}

#else

void __UDInfoClass(Class)
{
    
}



#endif

