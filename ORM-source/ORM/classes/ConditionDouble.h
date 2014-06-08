#import "Condition.h"

@interface ConditionDouble : Condition

- (instancetype)initWithFieldName:(NSString *)fieldName equalToDouble:(double)value;
- (instancetype)initWithFieldName:(NSString *)fieldName moreToDouble:(double)value;
- (instancetype)initWithFieldName:(NSString *)fieldName moreOrEqualToDouble:(double)value;
- (instancetype)initWithFieldName:(NSString *)fieldName lessToDouble:(double)value;
- (instancetype)initWithFieldName:(NSString *)fieldName lessOrEqualToDouble:(double)value;

@end