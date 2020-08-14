;;; Comments before function
; --  This is a comment
; function not_documented()
; end
(program
  (comment)
  (function_statement
    (function_name (identifier))
    (function_body_paren)
    (function_body_paren)
    (function_body_end)))

;;; Simple documentation
; --- hello world
; function cool_function()
;   return true
; end
(program
  (function_statement
    documentation: (emmy_documentation (emmy_comment))

    name: (function_name (identifier))
    (function_body_paren)
    (function_body_paren)
    body: (return_statement (boolean))
    (function_body_end)))

;;; Two lines of top level documentation
; --- hello world
; --- goodbye world
; function cool_function()
;   return true
; end
(program
  (function_statement
    documentation: (emmy_documentation (emmy_comment) (emmy_comment))

    name: (function_name (identifier))
    (function_body_paren)
    (function_body_paren)
    body: (return_statement (boolean))
    (function_body_end)))

;;; Full documentation
; --- A function description
; ---@param p string: param value
; ---@param x table: another value
; ---@return true
; function cool_function(p, x)
;   return true
; end
(program
  (function_statement
    documentation: (emmy_documentation
      (emmy_comment)

      (emmy_parameter
        name: (identifier)
        type: (emmy_type (identifier))
        description: (parameter_description))

      (emmy_parameter
        name: (identifier)
        type: (emmy_type (identifier))
        description: (parameter_description))

      (emmy_return
        type: (emmy_type (identifier))))

    name: (function_name (identifier))

    (function_body_paren)
    (parameter_list (identifier) (identifier))
    (function_body_paren)

    body: (return_statement (boolean))
    (function_body_end)))


;;; Multiple types with spaces
; --- A function description
; ---@param p string |  number : param value
; function cool_function(p) end
(program
  (function_statement
    documentation: (emmy_documentation
      (emmy_comment)

      (emmy_parameter
        name: (identifier)
        type: (emmy_type (identifier))
        type: (emmy_type (identifier))
        description: (parameter_description)))

    name: (function_name (identifier))

    (function_body_paren)
    (parameter_list (identifier))
    (function_body_paren)
    (function_body_end)))


;;; Should work for variables as well
; --- Example of my_func
; ---@param y string: Y description
; M.my_func = function(y)
; end
(program
  (variable_declaration
    documentation: (emmy_documentation
      (emmy_comment)
      (emmy_parameter
        name: (identifier)
        type: (emmy_type (identifier))
        description: (parameter_description)))

    name: (variable_declarator (identifier) (identifier))
    value: (function 
     (function_body_paren)
     (parameter_list (identifier))
     (function_body_paren)
     (function_body_end))))
