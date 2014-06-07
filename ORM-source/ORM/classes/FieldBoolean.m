#import "FieldBoolean.h"

@interface FieldBoolean ()

@property (nonatomic, strong) NSString *name;

@end

@implementation FieldBoolean

- (instancetype)initWithName:(NSString *)name
{
	self = [super init];
	if (self)
	{
		self.name = name;
	}
	return self;
}

- (ConditionBoolean *)isYES
{
	return [[ConditionBoolean alloc] initIsYESWithFieldName:self.name];
}

- (ConditionBoolean *)isNO
{
	return [[ConditionBoolean alloc] initIsNOWithFieldName:self.name];
}


@end
