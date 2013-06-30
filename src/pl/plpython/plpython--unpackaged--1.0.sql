/* src/pl/plpython/plpython--unpackaged--1.0.sql */

ALTER EXTENSION plpython ADD PROCEDURAL LANGUAGE plpython;
-- ALTER ADD LANGUAGE doesn't pick up the support functions, so we have to.
ALTER EXTENSION plpython ADD FUNCTION plpython_call_handler();
ALTER EXTENSION plpython ADD FUNCTION plpython_inline_handler(internal);
ALTER EXTENSION plpython ADD FUNCTION plpython_validator(oid);
