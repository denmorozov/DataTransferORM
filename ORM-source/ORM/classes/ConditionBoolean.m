#import "ConditionBoolean.h"

@interface ConditionBoolean ()

@property (nonatomic, strong) NSString *condition;

@end

@implementation ConditionBoolean

- (instancetype)initIsYESWithFieldName:(NSString *)fieldName
{
	self = [super init];
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ > 0)", fieldName];
	}
	return self;
}

- (instancetype)initIsNOWithFieldName:(NSString *)fieldName
{
	self = [super init];
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ != 0)", fieldName];
	}
	return self;
}

@end