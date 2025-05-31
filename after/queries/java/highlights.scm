; extends

(class_declaration
    name: (identifier) @spell)
(field_declaration
    declarator: (variable_declarator
        name: (identifier) @spell))
(method_declaration
  name: (identifier) @spell)

(local_variable_declaration(variable_declarator((identifier) @spell)))

