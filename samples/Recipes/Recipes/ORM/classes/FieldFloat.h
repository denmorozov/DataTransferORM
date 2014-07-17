
#import "ConditionFloat.h"

@interface FieldFloat : NSObject

- (instancetype)initWithName:(NSString *)name;

- (ConditionFloat *)equal:(CGFloat)value;
- (ConditionFloat *)more:(CGFloat)value;
- (ConditionFloat *)moreOrEqual:(CGFloat)value;
- (ConditionFloat *)less:(CGFloat)value;
- (ConditionFloat *)lessOrEqual:(CGFloat)value;

@end