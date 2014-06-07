#import "Condition.h"

@interface ConditionDate : Condition

- (instancetype)initWithFieldName:(NSString *)fieldName equalToDate:(NSDate *)value;
- (instancetype)initWithFieldName:(NSString *)fieldName moreToDate:(NSDate *)value;
- (instancetype)initWithFieldName:(NSString *)fieldName moreOrEqualToDate:(NSDate *)value;
- (instancetype)initWithFieldName:(NSString *)fieldName lessToDate:(NSDate *)value;
- (instancetype)initWithFieldName:(NSString *)fieldName lessOrEqualToDate:(NSDate *)value;
- (instancetype)initIsNULLWithFieldName:(NSString *)fieldName;

@end