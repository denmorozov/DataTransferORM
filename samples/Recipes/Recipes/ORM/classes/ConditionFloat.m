#import "ConditionFloat.h"

@interface ConditionFloat ()

@property (nonatomic, strong) NSString *condition;

@end

@implementation ConditionFloat

- (instancetype)initWithFieldName:(NSString *)fieldName equalToFloat:(CGFloat)value;
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ == %f)", fieldName, value];
	}
	
	return self;
}

- (instancetype)initWithFieldName:(NSString *)fieldName moreToFloat:(CGFloat)value
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ > %f)", fieldName, value];
	}
	
	return self;
}

- (instancetype)initWithFieldName:(NSString *)fieldName moreOrEqualToFloat:(CGFloat)value
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ >= %f)", fieldName, value];
	}
	
	return self;
}

- (instancetype)initWithFieldName:(NSString *)fieldName lessToFloat:(CGFloat)value
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ < %f)", fieldName, value];
	}
	
	return self;
}

- (instancetype)initWithFieldName:(NSString *)fieldName lessOrEqualToFloat:(CGFloat)value
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ <= %f)", fieldName, value];
	}
	
	return self;
}


@end