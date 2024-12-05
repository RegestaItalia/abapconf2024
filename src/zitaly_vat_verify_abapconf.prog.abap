*&---------------------------------------------------------------------*
*& Report zitaly_vat_verify_abapconf
*&---------------------------------------------------------------------*
*&
*& This report is part of the demo held at AbapConf 2024, in the       *
*& session "Making an OnPremise ABAP CI/CD with Github Actions"        *
*&
*&---------------------------------------------------------------------*
REPORT zitaly_vat_verify_abapconf.

DATA: ucomm(40),
      vat_number_input(13),
      message_container(50),
      icon_container(50),
      validation TYPE zcl_italy_vat_verify_abapconf=>ty_vat_verify_output.

CALL SCREEN 100.

*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*& Process before output                                               *
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET TITLEBAR 'MAIN_PAGE'.
  IF vat_number_input IS INITIAL.
*    icon_container = '@09@'.
    message_container = 'Waiting for VAT number input...'.
  ENDIF.
  LOOP AT SCREEN.
    IF screen-name EQ 'VIEW_DATA_BUTTON'.
*      IF validation-valid <> 'X'.
      screen-invisible = '1'.
*      ELSE.
*        screen-invisible = '0'.
*      ENDIF.
    ENDIF.
    MODIFY SCREEN.
  ENDLOOP.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*&
*& Process after input                                                 *
*&
*&---------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  IF ucomm EQ 'VIEW'.
    " view data...
  ELSE.
    CLEAR message_container.
    CLEAR icon_container.
    CLEAR validation.
    IF vat_number_input IS NOT INITIAL.
      validation = zcl_italy_vat_verify_abapconf=>verify( vat_number = CONV #( vat_number_input ) ).
      IF validation-valid EQ 'X'.
        icon_container = '@08@'.
      ELSE.
        icon_container = '@0A@'.
      ENDIF.
      message_container = validation-message.
    ENDIF.
  ENDIF.
  CLEAR ucomm.
ENDMODULE.
