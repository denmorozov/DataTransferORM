DataTransferORM
===============

ORM for objective-c

How to
------------------------

```orm.py --schema <xml_schema_path> --directory <output_dir_path>```

[schema format](https://github.com/denmorozov/DataTransferORM/wiki/Schema-format)

Notes
------------------------

Don't use many-to-many (will fix in next versions)

Don't use inverse properties in *struct* tag (will fix in next versions)

Don't use Circular references in DataBase (will fix in next versions)

In next versions
------------------------

Migration

Personal classes for every structs in *model* tag