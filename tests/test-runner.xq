xquery version "3.0";

(: https://github.com/joewiz/exist/wiki/xqsuite :)

import module namespace test="http://exist-db.org/xquery/xqsuite" 
at "resource:org/exist/xquery/lib/xqsuite/xqsuite.xql";

import module namespace tests="http://www.obdurodon.org/tests" at "test-suite.xq";

test:suite(
    inspect:module-functions(xs:anyURI("test-suite.xq"))
)
