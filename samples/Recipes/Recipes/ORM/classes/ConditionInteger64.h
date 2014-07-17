#import "Condition.h"

@interface ConditionInteger64 : Condition

- (instancetype)initWithFieldName:(NSString *)fieldName equalToInteger64:(int64_t)value;
- (instancetype)initWithFieldName:(NSString *)fieldName moreToInteger64:(int64_t)value;
- (instancetype)initWithFieldName:(NSString *)fieldName moreOrEqualToInteger64:(int64_t)value;
- (instancetype)initWithFieldName:(NSString *)fieldName lessToInteger64:(int64_t)value;
- (instancetype)initWithFieldName:(NSString *)fieldName lessOrEqualToInteger64:(int64_t)value;

@end