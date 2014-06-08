#import "ConditionDouble.h"

@interface ConditionDouble ()

@property (nonatomic, strong) NSString *condition;

@end

@implementation ConditionDouble

- (instancetype)initWithFieldName:(NSString *)fieldName equalToDouble:(double)value;
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ == %f)", fieldName, value];
	}
	
	return self;
}

- (instancetype)initWithFieldName:(NSString *)fieldName moreToDouble:(double)value
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ > %f)", fieldName, value];
	}
	
	return self;
}

- (instancetype)initWithFieldName:(NSString *)fieldName moreOrEqualToDouble:(double)value
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ >= %f)", fieldName, value];
	}
	
	return self;
}

- (instancetype)initWithFieldName:(NSString *)fieldName lessToDouble:(double)value
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ < %f)", fieldName, value];
	}
	
	return self;
}

- (instancetype)initWithFieldName:(NSString *)fieldName lessOrEqualToDouble:(double)value
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ <= %f)", fieldName, value];
	}
	
	return self;
}


@end