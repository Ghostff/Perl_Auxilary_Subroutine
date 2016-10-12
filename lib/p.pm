package p;
use strict;


sub log {
    my ($messge) = @_;
}

sub preg_replace {
    my ($pattern , $replacement, $subject) = @_;
    $subject =~ s{$pattern}{$replacement}im;
    return $subject;
}


sub str_replace {
    my ($search, $replacement, $subject) = @_;

    if (! ref $search) {
        log('$search must be refrenced');
    }
    elsif (! ref $replacement) {
        log('$replacement must be refrenced');
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
                    log('search size dosnt match replacement size');
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
            log('str replace does not support hashes');
        }
    }
    return $subject;
}


1;
