#import "Condition.h"

@interface ConditionInteger32 : Condition

- (instancetype)initWithFieldName:(NSString *)fieldName equalToInteger32:(int32_t)value;
- (instancetype)initWithFieldName:(NSString *)fieldName moreToInteger32:(int32_t)value;
- (instancetype)initWithFieldName:(NSString *)fieldName moreOrEqualToInteger32:(int32_t)value;
- (instancetype)initWithFieldName:(NSString *)fieldName lessToInteger32:(int32_t)value;
- (instancetype)initWithFieldName:(NSString *)fieldName lessOrEqualToInteger32:(int32_t)value;

@end