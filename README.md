DataTransferORM
===============

ORM for objective-c

Killer feature
------------------------

Fast development

How to
------------------------

**Step 1 - Create schema:**

```
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<schema>
	<entities>
		<entity name="Meal">
			<field name="name" type="string" />
			<relationship name="foods" inverse="meal" entity="Food" type="toMany" />
		</entity>
		<entity name="Food">
			<field name="name" type="string" />
			<field name="amount" type="float" />
			<relationship name="meal" inverse="foods" entity="Meal" type="toOne" />
		</entity>
	</entities>
	<models>
		<model name="NutritionModel">
			<struct entity="Meal">
				<property name="name" />
				<property name="foods">
					<property name="name" />
					<property name="amount" />
				</property>
			</struct>
			<struct entity="Food">
				<property name="name" />
				<property name="amount" />
			</struct>
		</model>
	</models>
</schema>
```

**Step 2 - Execute in MacOSX terminal:**

```python ORM-source/ORM/orm.py --schema <xml_schema_path> --directory <output_dir_path>```

**Step 3 - Copy and add files from <output_dir_path> to your project:**

**Step 4 - Using in your project:**

```
//create Food in DB
NutritionModel *model = [[NutritionModel alloc] init];
FoodDTO *f = [[FoodDTO alloc] init];
f.amount = 2.1f;
f.name = @"meat";
[model createFoodDTO:f];
```

```
//fetch Food objects from DB
NutritionModel *model = [[NutritionModel alloc] init];
NSArray *arr = [model foodObjectsWithComporator:^Condition *(NutritionModelFoodComporatorContext *ctx) {
    //follow code is equal to condition:
    //(((food.name = 'meat') OR (food.name = 'apple')) AND (food.amount > 1.5f))
    return AND( OR([ctx.name equal:@"meat"], [ctx.name equal:@"apple"], nil), [ctx.amount more:1.5f], nil);
}];
```

Features
------------------------

Create fetch condition is very simple

Create fetch condition is very simple

Notes
------------------------

Don't use many-to-many (will fix in next versions)

Don't use inverse properties in *struct* tag (will fix in next versions)

Don't use Circular references in DataBase (will fix in next versions)

In next versions
------------------------

Fix notes

Migration

Personal DTO-classes for every structs in *model* tag