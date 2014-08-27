
#import "ConditionBoolean.h"

@interface FieldBoolean : NSObject

- (instancetype)initWithName:(NSString *)name;

- (ConditionBoolean *)anyIsYES;
- (ConditionBoolean *)anyIsNO;
- (ConditionBoolean *)allIsYES;
- (ConditionBoolean *)allIsNO;
- (ConditionBoolean *)noneIsYES;
- (ConditionBoolean *)noneIsNO;

@end