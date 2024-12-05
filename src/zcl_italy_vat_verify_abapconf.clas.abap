CLASS zcl_italy_vat_verify_abapconf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.

  TYPES: BEGIN OF ty_vat_verify_output,
           valid TYPE flag,
           message TYPE string,
         END OF tY_VAT_VERIFY_OUTPUT.

  CLASS-METHODS verify
    IMPORTING vat_number TYPE string
    RETURNING VALUE(output) TYPE ty_vat_verify_output.

PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS zcl_italy_vat_verify_abapconf IMPLEMENTATION.

  METHOD verify.
    CLEAR output.
    TRY.
      output-valid = cl_abap_matcher=>create( pattern = '^IT\d{11}$'
                                              text    = vat_number )->match( ).
      IF output-valid EQ 'X'.
        output-message = 'Congrats, VAT number is valid.'.
      ELSE.
        output-message = 'VAT number is NOT valid!'.
      ENDIF.
    CATCH cx_dynamic_check.
      MESSAGE ID sy-msgid TYPE 'E' NUMBER sy-msgno WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 INTO output-message.
    ENDTRY.
  ENDMETHOD.

ENDCLASS.
