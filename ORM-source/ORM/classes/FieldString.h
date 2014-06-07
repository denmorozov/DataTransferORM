
#import "ConditionString.h"

@interface FieldString : NSObject

- (instancetype)initWithName:(NSString *)name;

- (ConditionString *)equal:(NSString *)string;
- (ConditionString *)like:(NSString *)pattern;
- (ConditionString *)null;

@end