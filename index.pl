use 5.10.0;
use strict;
use CGI;

use lib::p;


#as scalar
print p::str_replace(\'he', \'she', 'he is behind you');
#outputs she is behind you

#as array
my @patterns = ('he', 'is');
my @replacements = ('she', 'was');
print p::str_replace(\@patterns, \@replacements, 'he is behind you');
#outputs she was behind you
