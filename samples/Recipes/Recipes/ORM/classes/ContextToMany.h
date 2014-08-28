
#import "Condition.h"

@interface ContextToMany : NSObject

- (id)initWithName:(NSString *)name;

- (Condition *)empty;
- (Condition *)notEmpty;

@end