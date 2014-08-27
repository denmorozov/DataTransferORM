#import "Condition.h"

@interface ConditionString : Condition

- (instancetype)initWithFieldName:(NSString *)fieldName equalToString:(NSString *)string;
- (instancetype)initWithFieldName:(NSString *)fieldName likeToPattern:(NSString *)pattern;
- (instancetype)initIsNULLWithFieldName:(NSString *)fieldName;
- (instancetype)initWithFieldName:(NSString *)fieldName equalToString:(NSString *)string withOperation:(ConditionAggregateOperation)operation;
- (instancetype)initWithFieldName:(NSString *)fieldName likeToPattern:(NSString *)pattern withOperation:(ConditionAggregateOperation)operation;
- (instancetype)initIsNULLWithFieldName:(NSString *)fieldName withOperation:(ConditionAggregateOperation)operation;

@end