
#import "ConditionDouble.h"

@interface FieldDouble : NSObject

- (instancetype)initWithName:(NSString *)name;

- (ConditionDouble *)equal:(double)value;
- (ConditionDouble *)more:(double)value;
- (ConditionDouble *)moreOrEqual:(double)value;
- (ConditionDouble *)less:(double)value;
- (ConditionDouble *)lessOrEqual:(double)value;

@end