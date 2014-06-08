
#import "ConditionDouble.h"

@interface FieldFloat : NSObject

- (instancetype)initWithName:(NSString *)name;

- (ConditionDouble *)equal:(double)value;
- (ConditionDouble *)more:(double)value;
- (ConditionDouble *)moreOrEqual:(double)value;
- (ConditionDouble *)less:(double)value;
- (ConditionDouble *)lessOrEqual:(double)value;

@end