
#import "ConditionBoolean.h"

@interface FieldBooleanToMany : NSObject

- (instancetype)initWithName:(NSString *)name;

- (ConditionBoolean *)anyIsYES;
- (ConditionBoolean *)anyIsNO;
- (ConditionBoolean *)allIsYES;
- (ConditionBoolean *)allIsNO;
- (ConditionBoolean *)noneIsYES;
- (ConditionBoolean *)noneIsNO;

@end