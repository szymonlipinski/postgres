/* src/pl/plpython/plpython2--unpackaged--1.0.sql */

ALTER EXTENSION plpython2 ADD PROCEDURAL LANGUAGE plpython2;
-- ALTER ADD LANGUAGE doesn't pick up the support functions, so we have to.
ALTER EXTENSION plpython2 ADD FUNCTION plpython2_call_handler();
ALTER EXTENSION plpython2 ADD FUNCTION plpython2_inline_handler(internal);
ALTER EXTENSION plpython2 ADD FUNCTION plpython2_validator(oid);
