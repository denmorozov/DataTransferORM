#import "Condition.h"

@interface ConditionFloat : Condition

- (instancetype)initWithFieldName:(NSString *)fieldName equalToFloat:(CGFloat)value;
- (instancetype)initWithFieldName:(NSString *)fieldName moreToFloat:(CGFloat)value;
- (instancetype)initWithFieldName:(NSString *)fieldName moreOrEqualToFloat:(CGFloat)value;
- (instancetype)initWithFieldName:(NSString *)fieldName lessToFloat:(CGFloat)value;
- (instancetype)initWithFieldName:(NSString *)fieldName lessOrEqualToFloat:(CGFloat)value;

@end