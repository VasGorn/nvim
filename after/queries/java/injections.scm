; extends

((local_variable_declaration
  type: (type_identifier) @_type
  declarator: (variable_declarator
                name: (identifier) @_name
                value: (string_literal(multiline_string_fragment) @injection.content)))

(#any-of? @_type "String")
(#any-of? @_name "sql")
(#set! injection.language "sql"))

