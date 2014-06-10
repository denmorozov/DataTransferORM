
#import "ConditionInteger32.h"

@interface FieldInteger32 : NSObject

- (instancetype)initWithName:(NSString *)name;

- (ConditionInteger32 *)equal:(int32_t)value;
- (ConditionInteger32 *)more:(int32_t)value;
- (ConditionInteger32 *)moreOrEqual:(int32_t)value;
- (ConditionInteger32 *)less:(int32_t)value;
- (ConditionInteger32 *)lessOrEqual:(int32_t)value;

@end