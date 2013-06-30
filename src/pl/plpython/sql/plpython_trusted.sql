-- Checks for differences between trusted
-- and untrusted languages.


CREATE PROCEDURE trusted_x() RETURNS VOID
AS
'try:
  import sys
except ImportError:
  return "failed as expected"
return "succeeded, however it shouldn''t happen for plpython"' 
LANGUAGE PLPYTHON;


CREATE PROCEDURE trusted_x() RETURNS VOID
AS
'try:
  import sys
except ImportError:
  return "failed as expected"
return "succeeded, however it shouldn''t happen for plpython"' 
LANGUAGE PLPYTHONU;
