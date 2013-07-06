--
-- Test data type behavior
--

--
-- Base/common types
--

CREATE FUNCTION test_type_conversion_bool(x bool) RETURNS bool AS $$
plpy.info(x, type(x))
return x
$$ LANGUAGE plpythonu;

SELECT * FROM test_type_conversion_bool(true);
SELECT * FROM test_type_conversion_bool(false);
SELECT * FROM test_type_conversion_bool(null);


-- test various other ways to express Booleans in Python
CREATE FUNCTION test_type_conversion_bool_other(n int) RETURNS bool AS $$
# numbers
if n == 0:
   ret = 0
elif n == 1:
   ret = 5
# strings
elif n == 2:
   ret = ''
elif n == 3:
   ret = 'fa' # true in Python, false in PostgreSQL
# containers
elif n == 4:
   ret = []
elif n == 5:
   ret = [0]
plpy.info(ret, not not ret)
return ret
$$ LANGUAGE plpythonu;

SELECT * FROM test_type_conversion_bool_other(0);
SELECT * FROM test_type_conversion_bool_other(1);
SELECT * FROM test_type_conversion_bool_other(2);
SELECT * FROM test_type_conversion_bool_other(3);
SELECT * FROM test_type_conversion_bool_other(4);
SELECT * FROM test_type_conversion_bool_other(5);


CREATE FUNCTION test_type_conversion_char(x char) RETURNS char AS $$
plpy.info(x, type(x))
return x
$$ LANGUAGE plpythonu;

SELECT * FROM test_type_conversion_char('a');
SELECT * FROM test_type_conversion_char(null);


CREATE FUNCTION test_type_conversion_int2(x int2) RETURNS int2 AS $$
plpy.info(x, type(x))
return x
$$ LANGUAGE plpythonu;

SELECT * FROM test_type_conversion_int2(100::int2);
SELECT * FROM test_type_conversion_int2(-100::int2);
SELECT * FROM test_type_conversion_int2(null);


CREATE FUNCTION test_type_conversion_int4(x int4) RETURNS int4 AS $$
plpy.info(x, type(x))
return x
$$ LANGUAGE plpythonu;

SELECT * FROM test_type_conversion_int4(100);
SELECT * FROM test_type_conversion_int4(-100);
SELECT * FROM test_type_conversion_int4(null);


CREATE FUNCTION test_type_conversion_int8(x int8) RETURNS int8 AS $$
plpy.info(x, type(x))
return x
$$ LANGUAGE plpythonu;

SELECT * FROM test_type_conversion_int8(100);
SELECT * FROM test_type_conversion_int8(-100);
SELECT * FROM test_type_conversion_int8(5000000000);
SELECT * FROM test_type_conversion_int8(null);


CREATE FUNCTION test_type_conversion_numeric_tuple(
  x numeric,
  expected_sign int,
  expected_digits int[],
  expected_exponent int
) RETURNS numeric AS $$

t = x.as_tuple()

plpy.info(t.sign == expected_sign)
plpy.info(t.digits == tuple(expected_digits))
plpy.info(t.exponent == expected_exponent)

return x
$$ LANGUAGE plpythonu;


SELECT * FROM test_type_conversion_numeric_tuple(100, 0, ARRAY[1, 0, 0], 0);
SELECT * FROM test_type_conversion_numeric_tuple(-100, 1, ARRAY[1, 0, 0], 0);
SELECT * FROM test_type_conversion_numeric_tuple(5000000000.5, 0, ARRAY[5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5], -1 );
SELECT * FROM test_type_conversion_numeric_tuple(1234567890.0987654321, 0, ARRAY[1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 0, 9, 8, 7, 6, 5, 4, 3, 2, 1], -10);
SELECT * FROM test_type_conversion_numeric_tuple(-1234567890.0987654321, 1, ARRAY[1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 0, 9, 8, 7, 6, 5, 4, 3, 2, 1], -10);


CREATE FUNCTION test_type_conversion_numeric_string(
  x numeric,
  expected_string text
) RETURNS numeric AS $$
plpy.info(str(x) == expected_string)
return x
$$ LANGUAGE plpythonu;

SELECT * FROM test_type_conversion_numeric_string(100, '100');
SELECT * FROM test_type_conversion_numeric_string(-100, '-100');
SELECT * FROM test_type_conversion_numeric_string(5000000000.5, '5000000000.5');
SELECT * FROM test_type_conversion_numeric_string(1234567890.0987654321, '1234567890.0987654321');
SELECT * FROM test_type_conversion_numeric_string(-1234567890.0987654321, '-1234567890.0987654321');


CREATE FUNCTION test_type_conversion_numeric_int(
  x numeric,
  expected_value int
) RETURNS numeric AS $$
plpy.info(int(x) == expected_value)
return x
$$ LANGUAGE plpythonu;


SELECT * FROM test_type_conversion_numeric_int(100, 100);
SELECT * FROM test_type_conversion_numeric_int(-100, -100);


CREATE FUNCTION test_type_conversion_numeric_float(
  x numeric,
  expected_float float,
  epsilon float
) RETURNS numeric AS $$
plpy.info( abs(float(x) - expected_float) <= epsilon )
return x
$$ LANGUAGE plpythonu;


SELECT * FROM test_type_conversion_numeric_float(5000000000.5, 5000000000.5, 0);
SELECT * FROM test_type_conversion_numeric_float(1234567890.0987654321, 1234567890.0987654321, 0.00001);
SELECT * FROM test_type_conversion_numeric_float(-1234567890.0987654321, -1234567890.0987654321, 0.00001);


CREATE FUNCTION test_type_conversion_numeric_null(x numeric) RETURNS numeric AS $$
return x
$$ LANGUAGE plpythonu;

SELECT * FROM test_type_conversion_numeric_null(null);


CREATE FUNCTION test_type_conversion_float4(x float4) RETURNS float4 AS $$
plpy.info(x, type(x))
return x
$$ LANGUAGE plpythonu;

SELECT * FROM test_type_conversion_float4(100);
SELECT * FROM test_type_conversion_float4(-100);
SELECT * FROM test_type_conversion_float4(5000.5);
SELECT * FROM test_type_conversion_float4(null);


CREATE FUNCTION test_type_conversion_float8(x float8) RETURNS float8 AS $$
plpy.info(x, type(x))
return x
$$ LANGUAGE plpythonu;

SELECT * FROM test_type_conversion_float8(100);
SELECT * FROM test_type_conversion_float8(-100);
SELECT * FROM test_type_conversion_float8(5000000000.5);
SELECT * FROM test_type_conversion_float8(null);


CREATE FUNCTION test_type_conversion_oid(x oid) RETURNS oid AS $$
plpy.info(x, type(x))
return x
$$ LANGUAGE plpythonu;

SELECT * FROM test_type_conversion_oid(100);
SELECT * FROM test_type_conversion_oid(2147483649);
SELECT * FROM test_type_conversion_oid(null);


CREATE FUNCTION test_type_conversion_text(x text) RETURNS text AS $$
plpy.info(x, type(x))
return x
$$ LANGUAGE plpythonu;

SELECT * FROM test_type_conversion_text('hello world');
SELECT * FROM test_type_conversion_text(null);


CREATE FUNCTION test_type_conversion_bytea(x bytea) RETURNS bytea AS $$
plpy.info(x, type(x))
return x
$$ LANGUAGE plpythonu;

SELECT * FROM test_type_conversion_bytea('hello world');
SELECT * FROM test_type_conversion_bytea(E'null\\000byte');
SELECT * FROM test_type_conversion_bytea(null);


CREATE FUNCTION test_type_marshal() RETURNS bytea AS $$
import marshal
return marshal.dumps('hello world')
$$ LANGUAGE plpythonu;

CREATE FUNCTION test_type_unmarshal(x bytea) RETURNS text AS $$
import marshal
try:
    return marshal.loads(x)
except ValueError, e:
    return 'FAILED: ' + str(e)
$$ LANGUAGE plpythonu;

SELECT test_type_unmarshal(x) FROM test_type_marshal() x;


--
-- Domains
--

CREATE DOMAIN booltrue AS bool CHECK (VALUE IS TRUE OR VALUE IS NULL);

CREATE FUNCTION test_type_conversion_booltrue(x booltrue, y bool) RETURNS booltrue AS $$
return y
$$ LANGUAGE plpythonu;

SELECT * FROM test_type_conversion_booltrue(true, true);
SELECT * FROM test_type_conversion_booltrue(false, true);
SELECT * FROM test_type_conversion_booltrue(true, false);


CREATE DOMAIN uint2 AS int2 CHECK (VALUE >= 0);

CREATE FUNCTION test_type_conversion_uint2(x uint2, y int) RETURNS uint2 AS $$
plpy.info(x, type(x))
return y
$$ LANGUAGE plpythonu;

SELECT * FROM test_type_conversion_uint2(100::uint2, 50);
SELECT * FROM test_type_conversion_uint2(100::uint2, -50);
SELECT * FROM test_type_conversion_uint2(null, 1);


CREATE DOMAIN nnint AS int CHECK (VALUE IS NOT NULL);

CREATE FUNCTION test_type_conversion_nnint(x nnint, y int) RETURNS nnint AS $$
return y
$$ LANGUAGE plpythonu;

SELECT * FROM test_type_conversion_nnint(10, 20);
SELECT * FROM test_type_conversion_nnint(null, 20);
SELECT * FROM test_type_conversion_nnint(10, null);


CREATE DOMAIN bytea10 AS bytea CHECK (octet_length(VALUE) = 10 AND VALUE IS NOT NULL);

CREATE FUNCTION test_type_conversion_bytea10(x bytea10, y bytea) RETURNS bytea10 AS $$
plpy.info(x, type(x))
return y
$$ LANGUAGE plpythonu;

SELECT * FROM test_type_conversion_bytea10('hello wold', 'hello wold');
SELECT * FROM test_type_conversion_bytea10('hello world', 'hello wold');
SELECT * FROM test_type_conversion_bytea10('hello word', 'hello world');
SELECT * FROM test_type_conversion_bytea10(null, 'hello word');
SELECT * FROM test_type_conversion_bytea10('hello word', null);


--
-- Arrays
--

CREATE FUNCTION test_type_conversion_array_int4(x int4[]) RETURNS int4[] AS $$
plpy.info(x, type(x))
return x
$$ LANGUAGE plpythonu;

SELECT * FROM test_type_conversion_array_int4(ARRAY[0, 100]);
SELECT * FROM test_type_conversion_array_int4(ARRAY[0,-100,55]);
SELECT * FROM test_type_conversion_array_int4(ARRAY[NULL,1]);
SELECT * FROM test_type_conversion_array_int4(ARRAY[]::integer[]);
SELECT * FROM test_type_conversion_array_int4(NULL);
SELECT * FROM test_type_conversion_array_int4(ARRAY[[1,2,3],[4,5,6]]);


CREATE FUNCTION test_type_conversion_array_text(x text[]) RETURNS text[] AS $$
plpy.info(x, type(x))
return x
$$ LANGUAGE plpythonu;

SELECT * FROM test_type_conversion_array_text(ARRAY['foo', 'bar']);


CREATE FUNCTION test_type_conversion_array_bytea(x bytea[]) RETURNS bytea[] AS $$
plpy.info(x, type(x))
return x
$$ LANGUAGE plpythonu;

SELECT * FROM test_type_conversion_array_bytea(ARRAY[E'\\xdeadbeef'::bytea, NULL]);


CREATE FUNCTION test_type_conversion_array_mixed1() RETURNS text[] AS $$
return [123, 'abc']
$$ LANGUAGE plpythonu;

SELECT * FROM test_type_conversion_array_mixed1();


CREATE FUNCTION test_type_conversion_array_mixed2() RETURNS int[] AS $$
return [123, 'abc']
$$ LANGUAGE plpythonu;

SELECT * FROM test_type_conversion_array_mixed2();


CREATE FUNCTION test_type_conversion_array_record() RETURNS type_record[] AS $$
return [None]
$$ LANGUAGE plpythonu;

SELECT * FROM test_type_conversion_array_record();


CREATE FUNCTION test_type_conversion_array_string() RETURNS text[] AS $$
return 'abc'
$$ LANGUAGE plpythonu;

SELECT * FROM test_type_conversion_array_string();

CREATE FUNCTION test_type_conversion_array_tuple() RETURNS text[] AS $$
return ('abc', 'def')
$$ LANGUAGE plpythonu;

SELECT * FROM test_type_conversion_array_tuple();

CREATE FUNCTION test_type_conversion_array_error() RETURNS int[] AS $$
return 5
$$ LANGUAGE plpythonu;

SELECT * FROM test_type_conversion_array_error();


---
--- Composite types
---

CREATE TABLE employee (
    name text,
    basesalary integer,
    bonus integer
);

INSERT INTO employee VALUES ('John', 100, 10), ('Mary', 200, 10);

CREATE OR REPLACE FUNCTION test_composite_table_input(e employee) RETURNS integer AS $$
return e['basesalary'] + e['bonus']
$$ LANGUAGE plpythonu;

SELECT name, test_composite_table_input(employee.*) FROM employee;

ALTER TABLE employee DROP bonus;

SELECT name, test_composite_table_input(employee.*) FROM employee;

ALTER TABLE employee ADD bonus integer;
UPDATE employee SET bonus = 10;

SELECT name, test_composite_table_input(employee.*) FROM employee;

CREATE TYPE named_pair AS (
    i integer,
    j integer
);

CREATE OR REPLACE FUNCTION test_composite_type_input(p named_pair) RETURNS integer AS $$
return sum(p.values())
$$ LANGUAGE plpythonu;

SELECT test_composite_type_input(row(1, 2));

ALTER TYPE named_pair RENAME TO named_pair_2;

SELECT test_composite_type_input(row(1, 2));


--
-- Prepared statements
--

CREATE OR REPLACE FUNCTION test_prep_bool_input() RETURNS int
LANGUAGE plpythonu
AS $$
plan = plpy.prepare("SELECT CASE WHEN $1 THEN 1 ELSE 0 END AS val", ['boolean'])
rv = plpy.execute(plan, ['fa'], 5) # 'fa' is true in Python
return rv[0]['val']
$$;

SELECT test_prep_bool_input(); -- 1


CREATE OR REPLACE FUNCTION test_prep_bool_output() RETURNS bool
LANGUAGE plpythonu
AS $$
plan = plpy.prepare("SELECT $1 = 1 AS val", ['int'])
rv = plpy.execute(plan, [0], 5)
plpy.info(rv[0])
return rv[0]['val']
$$;

SELECT test_prep_bool_output(); -- false


CREATE OR REPLACE FUNCTION test_prep_bytea_input(bb bytea) RETURNS int
LANGUAGE plpythonu
AS $$
plan = plpy.prepare("SELECT octet_length($1) AS val", ['bytea'])
rv = plpy.execute(plan, [bb], 5)
return rv[0]['val']
$$;

SELECT test_prep_bytea_input(E'a\\000b'); -- 3 (embedded null formerly truncated value)


CREATE OR REPLACE FUNCTION test_prep_bytea_output() RETURNS bytea
LANGUAGE plpythonu
AS $$
plan = plpy.prepare("SELECT decode('aa00bb', 'hex') AS val")
rv = plpy.execute(plan, [], 5)
plpy.info(rv[0])
return rv[0]['val']
$$;

SELECT test_prep_bytea_output();
