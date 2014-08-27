#import "ContextToMany.h"

@interface ContextToMany ()

@property (nonatomic, strong) NSString *name;

@end

@implementation ContextToMany

- (id)initWithName:(NSString *)name
{
	if ( (self = [super init]) )
	{
		self.name = name;
	}
}

- (Condition *)empty
{
	return [[Condiciton] initWithCondition:[NSString stringWithFormat:@"(%@.@count == 0)", self.name]];
}

- (Condition *)notEmpty
{
	return [[Condiciton] initWithCondition:[NSString stringWithFormat:@"(%@.@count != 0)", self.name]];
}

@end
