#import "Condition.h"

@interface ConditionBoolean : Condition

- (instancetype)initIsYESWithFieldName:(NSString *)fieldName;
- (instancetype)initIsNOWithFieldName:(NSString *)fieldName;

@end