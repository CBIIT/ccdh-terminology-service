CALL n10s.graphconfig.init();

CREATE CONSTRAINT n10s_unique_uri ON (r:Resource) ASSERT r.uri IS UNIQUE;

CALL n10s.graphconfig.init({
  handleVocabUris: 'MAP'
});

CALL n10s.nsprefixes.add(
    'neo4voc',
    'http://neo4j.org/vocab/sw#'
);

call n10s.nsprefixes.addFromText("
@prefix iso-11179: <http://www.iso.org/11179/> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix skos: <http://www.w3.org/2004/02/skos/core#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix ccdh: <https://www.cancer.gov/ccdh/> .
@prefix gdc: <https://gdc.cancer.gov/> .
@prefix pdc: <https://pdc.cancer.gov/> .
@prefix htan: <https://humantumoratlas.org/> .
");

// Nodes
call n10s.mapping.add('http://www.iso.org/11179/DataElement', 'DataElement');
call n10s.mapping.add('http://www.iso.org/11179/DataElementConcept', 'DataElementConcept');
call n10s.mapping.add('http://www.iso.org/11179/ValueDomain', 'ValueDomain');
call n10s.mapping.add('http://www.iso.org/11179/PermissibleValue', 'PermissibleValue');
call n10s.mapping.add('http://www.iso.org/11179/ConceptualDomain', 'ConceptualDomain');
call n10s.mapping.add('http://www.iso.org/11179/ValueMeaning', 'ValueMeaning');
call n10s.mapping.add('http://www.w3.org/2004/02/skos/core#Concept', 'Concept');
call n10s.mapping.add('http://www.w3.org/2004/02/skos/core#Collection', 'CodeSet');
call n10s.mapping.add('http://www.w3.org/2004/02/skos/core#ConceptSheme', 'ConceptScheme');

// Object Properties
call n10s.mapping.add('http://www.iso.org/11179/dataElement.hasMeaning', 'HAS_MEANING');
call n10s.mapping.add('http://www.iso.org/11179/valueMeaning.hasRepresentation', 'HAS_REPRESENTATION');
call n10s.mapping.add('http://www.iso.org/11179/uses', 'USES');
call n10s.mapping.add('http://www.iso.org/11179/dataElementConcept.hasObjectClass', 'HAS_OBJECT_CLASS');
call n10s.mapping.add('http://www.iso.org/11179/dataElementConcept.hasProperty', 'HAS_PROPERTY');
call n10s.mapping.add('http://www.w3.org/2004/02/skos/core#member', 'HAS_MEMBER');

// Datatype Properties
call n10s.mapping.add('http://www.w3.org/2004/02/skos/core#definition', 'definition');
call n10s.mapping.add('http://www.w3.org/2004/02/skos/core#prefLabel', 'prefLabel');
call n10s.mapping.add('http://www.w3.org/2004/02/skos/core#altLabel', 'altLabel');
call n10s.mapping.add('http://www.w3.org/2004/02/skos/core#notation', 'notation');
call n10s.mapping.add('http://www.w3.org/2004/02/skos/core#inScheme', 'inScheme');
call n10s.mapping.add('http://www.w3.org/2004/02/skos/core#note', 'note');
call n10s.mapping.add('http://www.w3.org/2004/02/skos/core#changeNote', 'changeNote');
call n10s.mapping.add('http://www.w3.org/2004/02/skos/core#scopeNote', 'scopeNote');
call n10s.mapping.add('http://www.w3.org/2004/02/skos/core#historyNote', 'historyNote');
call n10s.mapping.add('http://www.w3.org/2004/02/skos/core#editorialNote', 'editorialNote');
call n10s.mapping.add('http://www.w3.org/2004/02/skos/core#example', 'example');

call n10s.mapping.add('https://www.cancer.gov/ccdh/context', 'context');
call n10s.mapping.add('https://www.cancer.gov/ccdh/entity', 'entity');
call n10s.mapping.add('https://www.cancer.gov/ccdh/attribute', 'attribute');
call n10s.mapping.add('https://www.cancer.gov/ccdh/objectClass', 'objectClass');
call n10s.mapping.add('https://www.cancer.gov/ccdh/proprety', 'property');


// INDEXES
CREATE INDEX data_element_entity_idx FOR (n:DataElement) ON (n.entity);
CREATE INDEX data_element_attribute_idx FOR (n:DataElement) ON (n.attribute);
CREATE INDEX data_element_context_idx FOR (n:DataElement) ON (n.context);

CREATE INDEX data_element_concept_context_idx FOR (n:DataElementConcept) ON (n.context);
CREATE INDEX data_element_concept_objectClass_idx FOR (n:DataElementConcept) ON (n.objectClass);
CREATE INDEX data_element_concept_property_idx FOR (n:DataElementConcept) ON (n.property);

CREATE INDEX permissible_value_prefLabel_idx FOR (n:PermissibleValue) ON (n.prefLabel);
