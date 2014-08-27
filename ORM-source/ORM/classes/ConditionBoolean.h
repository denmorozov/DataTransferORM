#import "Condition.h"

@interface ConditionBoolean : Condition

- (instancetype)initIsYESWithFieldName:(NSString *)fieldName;
- (instancetype)initIsNOWithFieldName:(NSString *)fieldName;
- (instancetype)initIsNOWithFieldName:(NSString *)fieldName withAggregateOperation:(ConditionAggregateOperation)aggregateOperation;
- (instancetype)initIsYESWithFieldName:(NSString *)fieldName withAggregateOperation:(ConditionAggregateOperation)aggregateOperation;

@end