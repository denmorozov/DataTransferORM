
#import "ConditionBoolean.h"

@interface FieldBoolean : NSObject

- (instancetype)initWithName:(NSString *)name;

- (ConditionBoolean *)isYES;
- (ConditionBoolean *)isNO;

@end