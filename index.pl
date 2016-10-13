use 5.10.0;
use strict;
use CGI;

use lib::p;


print p::str_replace(\'he', \'she', 'he is behind you');
#outputs (he is behind you)
my @patterns = ('he', 'is');
my @replacements = ('she', 'was');
print p::str_replace(\@patterns, \@replacements, 'he is behind you');
#outputs (he was behind you)


print p::str_repeat('+', 5);
#outputs (+++++)


print p::preg_replace('([\-]*)(.*)([\-]*)', '$2', '- Foo Bar -')
#outputs ( Foo Bar )


print p::trim(' Foo Bar ')
#outputs (Foo Bar)
print p::trim('- Foo-Bar -', '-')
#outputs ( Foo-Bar )
print p::ltrim(' Foo Bar ')
#outputs (Foo Bar )
print p::ltrim('- Foo-Bar -', '-')
#outputs ( Foo-Bar -)
print p::rtrim(' Foo Bar ')
#outputs ( Foo Bar)
print p::rtrim('- Foo-Bar -', '-')
#outputs (- Foo-Bar )


print p::explode(' ', 'Foo Bar FooBar BarFoo')
#outputs ([0 => Foo [1] => Bar [2] => FooBar [3] => BarFoo])
print p::explode(',', 'Foo,Bar,FooBar,BarFoo')
#outputs ([0 => Foo [1] => Bar [2] => FooBar [3] => BarFoo])


print p:implode(('Foo', 'Bar', 'FooBar', 'BarFoo'))
#outputs (FooBarFooBarBarFoo)
print p:implode(', ', ('Foo', 'Bar', 'FooBar', 'BarFoo'))
#outputs (Foo, Bar, FooBar, BarFoo)


print p::mt_rand();
#outputs (77361836761)
print p::mt_rand(4, 10);
#ouputs (7)


print p::range(1, 5);
# outputs ([0] => 1 [1] => 2 [2] => 3 [3] => 4 [4] => 5)
print p::range('a', 'e');
# outputs ([0] => a [1] => b [2] => c [3] => d [4] => e)
print p::range(1, 5, 2);
# outputs ([0] => 1 [1] => 3 [2] => 5)
print p::range('a', 'e', 2);
# outputs ([0] => a [1] => c [2] => e)


print p::array_fill(5, 4, 'Foobar');
#outputs  ([5] => Foobar [6] => Foobar [7] => Foobar [8] => Foobar)
print p::array_fill(-5, 6, 'BarFoo');
#outputs  ( [-5] => BarFoo [0] => BarFoo [1] => BarFoo [2] => BarFoo [3] => BarFoo [4] => BarFoo)
