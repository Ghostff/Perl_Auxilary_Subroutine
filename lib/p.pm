package p;
use strict;

# Send an error message to the defined error handling routines
sub error_log {
    my ($messge) = @_;
}

# Perform a regular expression search and replace
sub preg_replace {
    my ($pattern , $replacement, $subject) = @_;

    my $code = 'sub {
        $_[0] =~ s{$pattern}{'. $replacement . '}ig
    }';
    my $re = eval $code;
    $re->($subject);

    return $subject;
}

# Replace all occurrences of the search string with the replacement string
sub str_replace {
    my ($search, $replacement, $subject) = @_;

    if (! ref $search) {
        error_log('$search must be refrenced');
    }
    elsif (! ref $replacement) {
        error_log('$replacement must be refrenced');
    }
    else {

        if (ref($search) eq "SCALAR") {
            return preg_replace($$search, $$replacement, $subject);
        }
        elsif (ref($search) eq "ARRAY") {
            my $search_size = scalar( @{$search} );

            my $replaced;

            if (ref($replacement) eq "ARRAY") {
                my $replacement_size = scalar( @{$replacement} );

                if ($search_size != $replacement_size) {
                    error_log('search size dosnt match replacement size');
                }
                else {
                    for (my $i = 0; $i < $search_size; $i++) {
                        $subject = preg_replace($search->[$i], $replacement->[$i], $subject);
                    }
                }
            }
            else {
                for (my $i = 0; $i < $search_size; $i++) {
                    $subject = preg_replace($search->[$i], $$replacement, $subject);
                }
            }
        }
        elsif (ref($search) eq "HASH") {
            error_log('str replace does not support hashes');
        }
    }
    return $subject;
}

# Strip whitespace (or other characters) from the beginning and end of a string
sub trim {
    my ($string, $character_mask) = @_;

    print Dumper($string);

    print '<br />';
    if (defined($character_mask)) {
        $string = preg_replace("([\\$character_mask]*)(.+)([\\$character_mask]+)", '$2', $string);
    }
    else {
        $string = preg_replace('(\s*)(.+)\b(\s*)', '$2', $string);

    }
    print Dumper($string);
}

# Strip whitespace (or other characters) from the beginning of a string
sub ltrim {
    my ($string, $character_mask) = @_;

    if (defined($character_mask)) {
        $string = preg_replace("([\\$character_mask]*)(.+)", '$2', $string);
    }
    else {
        $string = preg_replace('(\s*)(.+)\b(\s*)', '$2', $string);
    }
    return $string;
}

#  Strip whitespace (or other characters) from the end of a string
sub rtrim {
    my ($string, $character_mask) = @_;

    if (defined($character_mask)) {
        $string = preg_replace("(.+)([\\$character_mask]+)", '$1', $string);
    }
    else {
        $string = preg_replace('(.+)\b(\s*)', '$1', $string);
    }
    return $string;
}
1;
