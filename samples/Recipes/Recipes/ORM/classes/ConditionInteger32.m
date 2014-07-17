#import "ConditionInteger32.h"

@interface ConditionInteger32 ()

@property (nonatomic, strong) NSString *condition;

@end

@implementation ConditionInteger32

- (instancetype)initWithFieldName:(NSString *)fieldName equalToInteger32:(int32_t)value;
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ == %i)", fieldName, value];
	}
	
	return self;
}

- (instancetype)initWithFieldName:(NSString *)fieldName moreToInteger32:(int32_t)value
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ > %i)", fieldName, value];
	}
	
	return self;
}

- (instancetype)initWithFieldName:(NSString *)fieldName moreOrEqualToInteger32:(int32_t)value
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ >= %i)", fieldName, value];
	}
	
	return self;
}

- (instancetype)initWithFieldName:(NSString *)fieldName lessToInteger32:(int32_t)value
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ < %i)", fieldName, value];
	}
	
	return self;
}

- (instancetype)initWithFieldName:(NSString *)fieldName lessOrEqualToInteger32:(int32_t)value
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ <= %i)", fieldName, value];
	}
	
	return self;
}


@end