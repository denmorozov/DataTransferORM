#import "ConditionDate.h"

@interface ConditionDate ()

@property (nonatomic, strong) NSString *condition;

@end

@implementation ConditionDate

- (instancetype)initWithFieldName:(NSString *)fieldName equalToDate:(NSDate *)value;
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ == '%@')", fieldName, value];
	}
	
	return self;
}

- (instancetype)initWithFieldName:(NSString *)fieldName moreToDate:(NSDate *)value
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ > '%@')", fieldName, value];
	}
	
	return self;
}

- (instancetype)initWithFieldName:(NSString *)fieldName moreOrEqualToDate:(NSDate *)value
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ >= '%@')", fieldName, value];
	}
	
	return self;
}

- (instancetype)initWithFieldName:(NSString *)fieldName lessToDate:(NSDate *)value
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ < '%@')", fieldName, value];
	}
	
	return self;
}

- (instancetype)initWithFieldName:(NSString *)fieldName lessOrEqualToDate:(NSDate *)value
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ <= '%@')", fieldName, value];
	}
	
	return self;
}

- (instancetype)initIsNULLWithFieldName:(NSString *)fieldName
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ == nil)", fieldName];
	}
	
	return self;
}

@end