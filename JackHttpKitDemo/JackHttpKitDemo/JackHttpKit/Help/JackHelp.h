#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define IS_NSSTRING_EMPTY(object)  !([object isKindOfClass:[NSString class]] && [(NSString *)object length])

@interface JackHelp : NSObject


+ (id)jsonToObj:(NSString *)json WithClassName:(Class)className;
+ (id)jsonToObj:(NSString *)json;
+ (id)objToJson:(id)obj;

@end
