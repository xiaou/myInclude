/**
 * @file UDebug.h
 * @brief 本人调试用的文件.
 * @note 调试时要把下面定义的宏UDebug设为1.EDebug在排错调试时设为1.
 * @warning 项目最终时"应该"把下面定义的宏UDebug设为0,"必须"把EDebug设为0.
 * @author hUyIncHun
 * @date 2010-2011
 * @version 5.1
 * @par 修改记录：
 *  -4.6:因为asm("int3")指令在真机下有问题，所以修改了UDBreak宏.
 *  -4.5:发现xcode4调试版默认添加宏DEBUG=1.
 *  -4.4:把宏点名字换了:UDLogFunc->UDInfoFunc.
 *  -4.3:增加#define UDASM __asm__ __volatile__.
 *  -4.2:增加打印函数信息点UDLogFunc宏.
 *  -4.12:清空修改记录.
 * @addtogroup UDebug 本人调试用的文件。
 * @{
 */

/**************************************************/
#ifndef _UDebug_h_
#define _UDebug_h_
/**************************************************/

#define UDebug 1
#define EDebug 1


#ifndef DEBUG //xcode4 release版本.
#ifdef UDebug
#undef UDebug
#endif
#ifdef EDebug
#undef EDebug
#endif
#define UDebug 0
#define EDebug 0
#endif


#ifdef __cplusplus 
#define EXTERN_C extern "C"
#else
#define EXTERN_C 
#endif


/// declare
//
#define UDASM __asm__ __volatile__
EXTERN_C void __UDInfoClass(Class cla);


///调试版本
//
#if UDebug
// {

#define UDLog(fmt, ...) NSLog(fmt, ##__VA_ARGS__)

#define UDBreak	   \
        raise(SIGTRAP);
		//UDASM("int3");\
		//UDASM("nop");

#define UDInfoClass(cla) __UDInfoClass(cla)

// }
#endif //_UDebug_


///非调试版本(发布版本的时候)
//
#if !UDebug 
// {

#define UDLog(fmt, ...)  

#define UDBreak   

#define UDInfoClass(cla) 

// }
#endif//_!UDebug_


///
//
#define UDInfoFunc UDLog(@"UDInfoFunc:\nline:%d %s", __LINE__, __func__)


/**************************************************/
#endif // _UDebug_h_
/** @} */

