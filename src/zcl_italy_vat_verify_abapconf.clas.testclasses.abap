*"* use this source file for your ABAP unit test classes
CLASS lcl_test DEFINITION FINAL FOR TESTING
                                      DURATION SHORT
                                      RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA: m_cut TYPE REF TO zcl_italy_vat_verify_abapconf.
    METHODS setup.
    METHODS verify_valid_vat FOR TESTING RAISING cx_static_check.
    METHODS verify_invalid_vat FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS lcl_test IMPLEMENTATION.

  METHOD setup.
    CREATE OBJECT m_cut.
  ENDMETHOD.

  METHOD verify_valid_vat.
    DATA(vat_number) = 'IT12345678901'.
    DATA(validation) = zcl_italy_vat_verify_abapconf=>verify( vat_number = CONV #( vat_number ) ).

    cl_abap_unit_assert=>assert_equals( msg = |VAT number { vat_number }|
                                        exp = 'X'
                                        act = validation-valid ).
  ENDMETHOD.

  METHOD verify_invalid_vat.
    DATA(vat_number) = 'ITINVALID'.
    DATA(validation) = zcl_italy_vat_verify_abapconf=>verify( vat_number = CONV #( vat_number ) ).

    cl_abap_unit_assert=>assert_equals( msg = |VAT number { vat_number }|
                                        exp = ' '
                                        act = validation-valid ).
  ENDMETHOD.

ENDCLASS.
