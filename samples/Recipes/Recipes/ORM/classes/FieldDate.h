
#import "ConditionDate.h"

@interface FieldDate : NSObject

- (instancetype)initWithName:(NSString *)name;

- (ConditionDate *)equal:(NSDate *)value;
- (ConditionDate *)more:(NSDate *)value;
- (ConditionDate *)moreOrEqual:(NSDate *)value;
- (ConditionDate *)less:(NSDate *)value;
- (ConditionDate *)lessOrEqual:(NSDate *)value;
- (ConditionDate *)null;

@end