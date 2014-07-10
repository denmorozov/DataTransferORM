from schema_parser.schema_structs import Field
from schema_parser.schema_structs import Relationship
from schema_parser.schema_structs import Entity
from schema_parser.schema_structs import ModelStructProperty
from schema_parser.schema_structs import ModelStruct
from schema_parser.schema_structs import Model
from schema_parser.create_dto_classes import createDTOClasses
from schema_parser.create_entities import createEntities

import glob
import os
import xml.etree.ElementTree as etree

def parseProperties(propertiesRoot, entityRoot, entities):
    properties = []
    for propertyElement in list(propertiesRoot):
        subproperties = None
        relationship = None
        entity = None
        if entityRoot != None:
            relationship = entityRoot.relationshipByName(propertyElement.attrib['name'])
        if relationship != None:
            entity = entities[relationship.entity.name]
        if len(list(propertyElement)) > 0:
            subproperties = parseProperties(propertyElement, entity, entities)
        if relationship != None and subproperties == None:
            subproperties = []
        id = propertyElement.attrib['id'] if ('id' in propertyElement.attrib) else None
        property = ModelStructProperty(propertyElement.attrib['name'], relationship, subproperties, id)
        properties.append(property)
    return properties

def parse(filePath):
    tree = etree.parse(filePath)
    root = tree.getroot()
    
    entityElements = list(root.findall('entities')[0])
    
    entities = {}
    
    for entityElement in entityElements:
        fields = []
        for entityItem in list(entityElement):
            if entityItem.tag == 'field':
                field = Field(entityItem.attrib['name'], entityItem.attrib['type'])
                fields.append(field)
        entity = Entity(entityElement.attrib['name'], fields, None)
        entities[entity.name] = entity
     
    for entityElement in entityElements:
        relationships = []
        entity = entities[entityElement.attrib['name']]
        for entityItem in list(entityElement):
            if entityItem.tag == 'relationship':
                r_entity = entities[entityItem.attrib['entity']]
                relationship = Relationship(entityItem.attrib['name'], entityItem.attrib['inverse'], r_entity, entityItem.attrib['type'])
                relationships.append(relationship)
        entity.relationships = relationships
    
    modelElements = root.findall('models')[0]
    
    models = []
    
    for modelElement in list(modelElements):
        structs = []
        for structElement in list(modelElement):
            entityName = structElement.attrib['entity']
            id = structElement.attrib['id'] if ('id' in structElement.attrib) else None
            
            properties = parseProperties(structElement, entities[entityName], entities)
            
            structs.append(ModelStruct(entities[entityName], properties, id))
        
        models.append(Model(modelElement.attrib['name'], structs))
    
    return [list(entities.values()), models]

