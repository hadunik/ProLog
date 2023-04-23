/*
 * This example shows how to include modules.
 * Here we include two modules mod1 and mod2 and then
 * access the predicates mod1:foo/1, mod2:foo/1 and mod2:bar/2
 * without mod1:some_helper/2 being
 * affected by the mod2:some_helper/2.
 */

:- use_module(mod1, []).
:- use_module(mod2, []).

use_mod1 :- mod1:foo("Alexey").
use_mod2 :- mod2:foo("Alexey"), mod2:bar([1,2,3,4,5], 4).

:- initialization((use_mod1, use_mod2), main).
