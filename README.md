DataTransferORM
===============

ORM for objective-c

How to
------------------------

```orm.py --schema <xml_schema_path> --directory <output_dir_path>```

[schema format](https://github.com/denmorozov/DataTransferORM/wiki/Schema-format)

Notes
------------------------

Don't use many-to-many

Don't use inverse properties in *struct* tag

Don't use Circular references in DataBase

In next versions
------------------------

Migration

Personal classes for every structs in *model* tag