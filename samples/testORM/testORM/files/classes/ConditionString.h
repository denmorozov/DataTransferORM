#import "Condition.h"

@interface ConditionString : Condition

- (instancetype)initWithFieldName:(NSString *)fieldName equalToString:(NSString *)string;
- (instancetype)initWithFieldName:(NSString *)fieldName likeToPattern:(NSString *)pattern;

@end