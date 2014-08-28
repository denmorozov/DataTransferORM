
#import "Condition.h"

@interface ContextToOne : NSObject

- (id)initWithName:(NSString *)name;

- (Condition *)null;
- (Condition *)notNull;

@end