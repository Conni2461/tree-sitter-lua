;;; Can do simple do block
; do x = 1 end
(program
  (do_statement
    (do_start)
    (variable_declaration
      (variable_declarator (identifier))
      (number))
    (do_end)))


;;; Can have do blocks with more than one thing
; do
;  x = 1
;  my_func()
; end
(program
  (do_statement
    (do_start)
    (variable_declaration
      (variable_declarator (identifier))
      (number))
    (function_call
      (identifier) (function_call_paren) (function_call_paren))
    (do_end)))

;;; While blocks
; while false do x = x + 1 end
(program
 (while_statement
  (while_start)
  (boolean)
  (while_do)
  (variable_declaration
    (variable_declarator (identifier))
    (binary_operation (identifier) (number)))
  (while_end)))

;;; Repeat block
; repeat x = x + 1 until true
(program
 (repeat_statement
  (repeat_start)
  (variable_declaration
    (variable_declarator (identifier))
    (binary_operation (identifier) (number)))
  (repeat_until)
  (boolean)))

;;; If blocks
; if x then return y end
(program
 (if_statement
  (if_start)
  (identifier)
  (if_then)
  (return_statement (identifier))
  (if_end)))

;;; If elseif else blocks
; if x == 0 then return y elseif x == nil then return 7 else return "str" end
(program
 (if_statement
  (if_start)
  (binary_operation (identifier) (number))
  (if_then)
  (return_statement (identifier))
  (if_elseif)
  (binary_operation (identifier) (nil))
  (if_then)
  (return_statement (number))
  (if_else)
  (return_statement (string))
  (if_end)))


;;; For loop, identifier style
; for x = 1, 10 do print(x) end
(program
 (for_statement
  (for_start)
  (for_numeric
    var: (identifier)
    start: (number)
    finish: (number))
  (for_do)
  (function_call 
    prefix: (identifier)
    (function_call_paren)
    args: (function_arguments (identifier))
    (function_call_paren))
  (for_end)))

;;; For loop, identifier style
; for x = 1, 10, z do print(x) end
(program
 (for_statement
  (for_start)
  (for_numeric
    var: (identifier)
    start: (number)
    finish: (number)
    step: (identifier))
  (for_do)
  (function_call 
    prefix: (identifier)
    (function_call_paren)
    args: (function_arguments (identifier))
    (function_call_paren))
  (for_end)))

;;; For loop, identifier style
; for k, v in ipairs(x) do print(k, v) end
(program
 (for_statement
  (for_start)
  (for_generic
    identifier_list: (identifier_list (identifier) (identifier))
    (for_in)
    expression_list: (function_call
      prefix: (identifier)
      (function_call_paren)
      args: (function_arguments (identifier))
      (function_call_paren)))
  (for_do)
  (function_call 
    prefix: (identifier)
    (function_call_paren)
    args: (function_arguments (identifier) (identifier))
    (function_call_paren))
  (for_end)))

;;; Returns from if statement with no values
; if not diagnostics then return end
(program
  (if_statement
   (if_start)
   (unary_operation (identifier))
   (if_then)
   (return_statement)
   (if_end)))
