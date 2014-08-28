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
	
	return self;
}

- (Condition *)empty
{
	return [[Condition alloc] initWithCondition:[NSString stringWithFormat:@"(%@.@count == 0)", self.name]];
}

- (Condition *)notEmpty
{
	return [[Condition alloc] initWithCondition:[NSString stringWithFormat:@"(%@.@count != 0)", self.name]];
}

@end
