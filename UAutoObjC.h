/**
 * @file UAutoObjC.h
 * @brief 在当前栈出栈时调用objective-c对象(CFTypeRef或NSObject皆可)的release函数一次.
 * @note 建议开启混编C++支持:xcode4配制BuildSettings/Compile Sources As/Objective-C++或改使用此工具的源文件扩展名为mm.
 * @warning ...
 * @author hUyIncHun
 * @date 2010-2011
 * @version 3.6
 * @par 修改记录：
 *  -3.5:支持了非c++ —— 只是为了兼容性.
 *  -3.0:增加_create_valueName.
 *  -2.0:确定CFRelease()会调用obj-c的-release实例函数.
 */


/**************************************************/
#ifndef _UAutoObjC_h_
#define _UAutoObjC_h_
/**************************************************/
#ifdef __cplusplus 
/**************************************************/
/// c++:
//
#define _create_valueName1(_prefix, _line)  _prefix##_line
#define _create_valueName0(_line)           _create_valueName1(__cautoobjc__, _line)
#define _create_valueName                   _create_valueName0(__LINE__)


/** 
 * @brief 作用:在使用这个宏的栈结束时对参数调用release.
 * @code
    NSObject* obj = [[NSObject alloc] init];
    UAutoObjC(obj);
   or:
    CFStringRef str = CFStringCreateWithCString(kCFAllocatorDefault, " ", kCFStringEncodingUTF8);
    UAutoObjC(str);
   @endcode
 */
#define UAutoObjC(_objc_obj_ptr_)   \
        \
        __CAutoObjC _create_valueName((void*)(_objc_obj_ptr_)) 


class __CAutoObjC
{
public:
    __CAutoObjC(void* _)
    {
        mObjC = _;
    }
    ~__CAutoObjC()
    {
        if(mObjC)
        {
            CFRelease(mObjC); 
        }
    }
    
private:
    void* mObjC;    
};

/**************************************************/
#else 
/**************************************************/
/// not c++:
//不支持CFTypeRef.会有警告，自行解决.
//
#define UAutoObjC(_objc_obj_ptr_)   [(id)_objc_obj_ptr_ autorelease]

/**************************************************/
#endif // __cplusplus
/**************************************************/
#endif // _UAutoObjC_h_


