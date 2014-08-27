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
}

- (Condition *)null
{
	return [[Condiciton] initWithCondition:[NSString stringWithFormat:@"(%@ == null)", self.name]];
}

- (Condition *)notNull
{
	return [[Condiciton] initWithCondition:[NSString stringWithFormat:@"(%@ != null)", self.name]];
}

@end
