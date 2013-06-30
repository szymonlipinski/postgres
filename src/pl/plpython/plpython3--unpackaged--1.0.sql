/* src/pl/plpython/plpython3--unpackaged--1.0.sql */

ALTER EXTENSION plpython3 ADD PROCEDURAL LANGUAGE plpython3;
-- ALTER ADD LANGUAGE doesn't pick up the support functions, so we have to.
ALTER EXTENSION plpython3 ADD FUNCTION plpython3_call_handler();
ALTER EXTENSION plpython3 ADD FUNCTION plpython3_inline_handler(internal);
ALTER EXTENSION plpython3 ADD FUNCTION plpython3_validator(oid);
