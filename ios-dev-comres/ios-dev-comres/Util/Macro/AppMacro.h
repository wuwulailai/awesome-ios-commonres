//
//  AppMacro.h
//  ios-dev-comres
//
//  Created by 吴保来 on 2017/3/21.
//  Copyright © 2017年 test. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h
////////////////////////////////////////////////////////////////////////////////
#pragma mark - Assert
/**
 * 断言，Debug和Release下启用，Distribution下不启用
 */
#ifndef DISTRIBUTION
#define CMAssert(condition, desc, ...)	\
do {				\
__PRAGMA_PUSH_NO_EXTRA_ARG_WARNINGS \
if (!(condition)) {		\
NSString *__assert_file__ = [NSString stringWithUTF8String:__FILE__]; \
__assert_file__ = __assert_file__ ? __assert_file__ : @"<Unknown File>"; \
[[NSAssertionHandler currentHandler] handleFailureInMethod:_cmd \
object:self file:__assert_file__ \
lineNumber:__LINE__ description:(desc), ##__VA_ARGS__]; \
}				\
__PRAGMA_POP_NO_EXTRA_ARG_WARNINGS \
} while(0)
#else
#define CMAssert(condition, desc, ...) do {} while (0)
#endif
#endif /* AppMacro_h */


////////////////////////////////////////////////////////////////////////////////
#pragma mark - AppSingle

#define CMUserDefault         [NSUserDefaults standardUserDefaults]
#define CMDefaultManager      [NSFileManager defaultManager]
#define CMDefaultCenter       [NSNotificationCenter defaultCenter]
#define CMSharedApplication   [UIApplication sharedApplication]


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Screen
/**
 * 屏幕宽度 高度 (注意，启动的时候窗口的创建不能用这个宏，6plus横屏启动会出错)
 */
#define SCREENWIDTH (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height))
#define SCREENHEIGHT (MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height))

// 以iPhone6为基准适配
#define HRatio (SCREENWIDTH / 375.0f)
#define VRatio (SCREENHEIGHT / 667.0f)

#define kStatusBarHeight 20
#define kNavigationBarHeight 44


////////////////////////////////////////////////////////////////////////////////
#pragma mark - warning ignore
// 忽略调用方法时产生的警告
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


////////////////////////////////////////////////////////////////////////////////
#pragma mark - RGB
/**
 * RGB颜色
 */
#define KKRGBColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define SeperatLineColor [UIColor colorWithHexString:@"e5e5e5"]


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Weak Strong

// weakSelf
#ifndef    weakify
#if __has_feature(objc_arc)

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x; \
_Pragma("clang diagnostic pop")

#else

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __block __typeof__(x) __block_##x##__ = x; \
_Pragma("clang diagnostic pop")

#endif
#endif

// strongSelf
#ifndef    strongify
#if __has_feature(objc_arc)

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __weak_##x##__; \
_Pragma("clang diagnostic pop")

#else

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __block_##x##__; \
_Pragma("clang diagnostic pop")

#endif
#endif

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Log
/*
 自定义log
 */
#ifndef DISTRIBUTION

#undef  LOG_LEVEL_DEF
#define LOG_LEVEL_DEF   DDLogLevelDebug

#define CMLog      DDLogDebug
#define CMAutom()  CMLog(@"enter")

#else

#define CMLog(FORMAT, ...)
#define CMAutom()

#endif

////////////////////////////////////////////////////////////////////////////////
/* AppMacro_h */
