
#import "ConditionInteger64.h"

@interface FieldInteger64 : NSObject

- (instancetype)initWithName:(NSString *)name;

- (ConditionInteger64 *)equal:(int64_t)value;
- (ConditionInteger64 *)more:(int64_t)value;
- (ConditionInteger64 *)moreOrEqual:(int64_t)value;
- (ConditionInteger64 *)less:(int64_t)value;
- (ConditionInteger64 *)lessOrEqual:(int64_t)value;

@end