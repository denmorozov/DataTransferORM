@class Condition;

Condition * OR(Condition *firstArg, ...);
Condition * AND(Condition *firstArg, ...);

@interface Condition : NSObject

- (NSPredicate *)predicate;

@end