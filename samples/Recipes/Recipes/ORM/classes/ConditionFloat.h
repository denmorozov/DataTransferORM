#import "Condition.h"

@interface ConditionFloat : Condition

- (instancetype)initWithFieldName:(NSString *)fieldName withOperator:(ConditionOperator)operator toFloat:(CGFloat)value;
- (instancetype)initWithFieldName:(NSString *)fieldName withOperator:(ConditionOperator)operator toFloat:(CGFloat)value withOperation:(ConditionAggregateOperation)operation;

@end