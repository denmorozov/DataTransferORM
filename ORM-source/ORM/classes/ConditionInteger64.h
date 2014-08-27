#import "Condition.h"

@interface ConditionInteger64 : Condition

- (instancetype)initWithFieldName:(NSString *)fieldName withOperator:(ConditionOperator)operator toInt64:(int64_t)value;
- (instancetype)initWithFieldName:(NSString *)fieldName withOperator:(ConditionOperator)operator toInt64:(int64_t)value withOperation:(ConditionAggregateOperation)operation;

@end