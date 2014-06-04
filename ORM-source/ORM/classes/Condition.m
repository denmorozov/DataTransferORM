#import "Condition.h"

@interface Condition ()

@end

@implementation Condition

- (NSPredicate *)predicate
{
	return [NSPredicate predicateWithFormat:self.condition];
}

- (NSString *)condition
{
	assert(false);
	return @"";
}

@end
