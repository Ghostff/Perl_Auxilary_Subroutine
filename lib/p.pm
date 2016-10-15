package p;
use strict;
use Data::Dumper;

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

    if (defined($character_mask)) {
        $string = preg_replace(
            '^[\\' . $character_mask . ']*|[\\' . $character_mask . ']*$',
            '$2',
            $string
        );
    }
    else {
        $string = preg_replace('^[\s]*|[\s]*$', '$2', $string);
    }
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
        $string = preg_replace('[\\' . $character_mask . ']*$', '$1', $string);
    }
    else {
        $string = preg_replace('[\s]*$', '$2', $string);
    }
    return $string;
}

# Split a string by string
sub explode {
    my ($delimiter, $string, $limit) = @_;
    my @pieces = split /$delimiter/, $string, $limit;
    return @pieces;
}

# Join array elements with a string Alias of join
sub implode {
    my ($glue , $pieces) = @_;

    if (! ref $glue) {
        error_log('glue must be refrenced');
    }
    else {
        if (ref($glue) ne "SCALAR") {
            if (defined($pieces)) {
                error_log('$glue must be a string');
            }
            else {
                $pieces = $glue;
                $glue = '';
            }
        }
    }
    return join($glue, @{$pieces});
}

# Repeat a string
sub str_repeat {
    my ($input, $multiplier ) = @_;
    return $input x $multiplier;
}

# Generate a better random value
sub mt_rand {
    my ($min, $max ) = @_;
    if (defined($min) && defined($max)) {
        RESPAWN:
          my $rand = int(rand($max+1));

        if ($rand >= $min) {
            return $rand;
        }
        else {
            goto RESPAWN;
        }
    }
    else {
        return int(rand(99999999999));
    }
}

# Create an array containing a range of elements
sub range {
    my ($start, $end, $step) = @_;

    if (defined($step)) {
        my @range;
        if($start =~ /^\w$/ && $end =~ /^\w$/) {
            my @new_range = ($start .. $end);
            for (my $i = 0; $i < scalar(@new_range); $i += $step) {
                push(@range, @new_range[$i]);
            }
        }
        else {
            for (my $i = $start; $i < $end; $i += 2) {
                push(@range, $i);
            }
        }
        return @range;
    }
    else {
        return ($start .. $end);
    }
}

# Split string by a regular expression
sub preg_split {
    my ($pattern, $subject, $limit) = @_;
    my @list = split(/$pattern/, $subject, $limit);
    return @list;
}

# Filters elements of an array using a callback function
sub array_filter {
}

# Fill an array with values
sub array_fill {
    my ($start_index, $num, $value) = @_;

    my @fill;
    for (my $i = 1; $i <= $num; $i++, $start_index++) {
        $fill[$start_index] = $value;
    }
    return @fill;
}

# Randomly shuffles a string
sub str_shuffle {
    my ($string) = @_;
    my @list = split(//, $string);

    my @new_list;
    my $length = scalar @list;

    for (my $i = 0; $i < $length; $i++) {

        OFFLOAD:
          my $shuffle = int(rand($length));

        if ( ! exists $new_list[$shuffle]) {
            $new_list[$shuffle] = $list[$i];
        }
        else {
            goto OFFLOAD;
        }
    }

    return join('', @new_list);
}
1;
