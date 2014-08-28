#import "ContextToOne.h"

@interface ContextToOne ()

@property (nonatomic, strong) NSString *name;

@end

@implementation ContextToOne

- (id)initWithName:(NSString *)name
{
	if ( (self = [super init]) )
	{
		self.name = name;
	}
	
	return self;
}

- (Condition *)null
{
	return [[Condition alloc] initWithCondition:[NSString stringWithFormat:@"(%@ == null)", self.name]];
}

- (Condition *)notNull
{
	return [[Condition alloc] initWithCondition:[NSString stringWithFormat:@"(%@ != null)", self.name]];
}

@end
