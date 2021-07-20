from faker import Faker

from linkml.generators.pythongen import PythonGenerator
from linkml_model import EnumDefinition, PermissibleValue, SchemaDefinition
from linkml_runtime.dumpers.yaml_dumper import YAMLDumper
from linkml_runtime.loaders.yaml_loader import YAMLLoader
from linkml_runtime.utils.compile_python import compile_python

fake = Faker()


model1 = '''
id: http://example.com/enum
prefixes:
  NCIT: http://ontologies-r.us/codesystem/
enums:
  analyte_type:
    description: Autogenerated Enumeration for CDM.specimen.analyte_type
    permissible_values:
      C449: DNA
      C174108:
        description: Nucleic RNA Sample
        meaning: NCIT:C174108
      C156436:
        description: Formalin-Fixed Paraffin-Embedded RNA
        meaning: NCIT:C156436
'''

model2 = '''
id: http://example.com/enum
prefixes:
  NCIT: http://ontologies-r.us/codesystem/
enums:
  analyte_type:
    description: Autogenerated Enumeration for CDM.specimen.analyte_type
    permissible_values:
    - text: C449
      description: DNA
    - text: C174108
      description: Nucleic RNA Sample
      meaning: NCIT:C174108
    - text: C156436
      description: Formalin-Fixed Paraffin-Embedded RNA
      meaning: NCIT:C156436
'''


def compile_model(model: str, print_python: bool=False) -> SchemaDefinition:
    gen = PythonGenerator(model, merge_imports=False, gen_classvars=False, gen_slots=False)
    code = gen.serialize()
    return code


def test_create_enum():
    enum = EnumDefinition(name='test')
    for i in range(10):
        pv = PermissibleValue(
            text=fake.name()
        )
        enum.permissible_values[fake.name()] = pv
    ds = YAMLDumper().dumps(enum)
    assert ds is not None


def test_create_enum_from_str():
    code1 = compile_model(model2, print_python=True)
    code2 = compile_model(model1, print_python=True)
    assert code1 == code2
    # module = YAMLLoader().loads(model, target_class=EnumDefinition)
    # print(YAMLDumper().dumps(module))


