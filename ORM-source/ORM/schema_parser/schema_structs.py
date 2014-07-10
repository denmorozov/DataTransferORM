from helpers import upperCaseForFirstSymbol

class Field:
    def __init__(self, name, type):
        self.name = name
        self.type = type

class Relationship:
    def __init__(self, name, inverse, entity, type):
        self.name = name
        self.inverse = inverse
        self.entity = entity
        self.type = type

class Entity:
    def __init__(self, name, fields, relationships):
        self.name = name
        self.fields = fields
        self.relationships = relationships
    def containsRelationshipWithName(self, name):
        for r in self.relationships:
            if r == name:
                return True
        return False
    def containsRelationshipWithNameAndInverse(self, name, inverse):
        for r in self.relationships:
            if r.name == name and r.inverse == inverse:
                return True
        return False
    def relationshipByName(self, name):
        for r in self.relationships:
            if r.name == name:
                return r
        return None
    def fieldByName(self, name):
        for f in self.fields:
            if f.name == name:
                return f
        return None

class StructClassDef:
    def __init__(self, name, entity, properties, id):
        self.name = name
        self.entity = entity
        self.properties = properties
        self.id = id

class ModelStructProperty:
    def __init__(self, name, relationship, properties, id):
        self.name = name
        self.relationship = relationship
        self.properties = properties
        self.id = id
    def entities(self):
        result = []
        if self.relationship != None:
            result.append(self.relationship.entity.name)
        if self.properties != None:
            for structProperty in self.properties:
                result += structProperty.entities()
        return result

class ModelStruct:
    def __init__(self, entity, properties, id):
        self.entity = entity
        self.properties = properties
        self.id = id
    def entities(self):
        result = [self.entity.name]
        for structProperty in self.properties:
            result += structProperty.entities()
        return result
    def classesDefs(self):
        return self.makeClassesDefs(self.model.name + self.entity.name, self.entity, self.properties, self.id)
    def classDefById(self, id):
        defs = self.classesDefs()
        for d in defs:
            if d.id == id:
                return d
        return None
    #private
    def makeClassesDefs(self, name, entity, properties, id):
        result = []
        if name != None:
            result.append(StructClassDef(name, entity, properties, id))
        for property in properties:
            if property.relationship != None:
                subname = None if property.id != None and len(property.properties) == 0 else name + upperCaseForFirstSymbol(property.relationship.name)
                result += self.makeClassesDefs(subname, property.relationship.entity, property.properties, property.id)
        return result;

class Model:
    def __init__(self, name, structs):
        self.name = name
        self.structs = structs
        for s in self.structs:
            s.model = self
    def entities(self):
        result = []
        for struct in self.structs:
            result += struct.entities()
        return list(set(result))
