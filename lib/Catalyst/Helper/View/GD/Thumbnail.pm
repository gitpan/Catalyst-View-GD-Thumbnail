package Catalyst::Helper::View::GD::Thumbnail;

use strict;

=head1 NAME

Catalyst::Helper::View::GD::Thumbnail - Helper for GD Thumbnail Views

=head1 SYNOPSIS

    Create a thumbnail view:

        script/myapp_create view Thumbnail Thumbnail

    Then in your controller:

        sub thumbnail :Local :Args(1) {
            my ($self, $c, $image_file_path) = @_;
        
            $c->stash->{x}     = 100;    # Create a 100px wide thumbnail
				
										 #or
					
			$c->stash->{y}     = 100;    # Create a 100px tall thumbnail
            $c->stash->{image} = $image_file_path;
        
            $c->forward('View::Thumbnail');
        }

=head1 DESCRIPTION

Helper for Thumbnail Views.

=head2 METHODS

=head3 mk_compclass

=cut

sub mk_compclass {
    my ( $self, $helper ) = @_;
    my $file = $helper->{file};
    $helper->render_file( 'compclass', $file );
}

=head1 AUTHOR

Nick Logan, L<nik_517@yahoo.com>

=head1 SEE ALSO

L<Catalyst::View::GD::Thumbnail>

=head1 COPYRIGHT & LICENSE

Copyright 2010 Nick Logan (ugexe), all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;

__DATA__

__compclass__
package [% class %];

use strict;
use parent 'Catalyst::View::GD::Thumbnail';

=head1 NAME

[% class %] - Thumbnail View for [% app %]

=head1 DESCRIPTION

Thumbnail View for [% app %]. 

=head1 AUTHOR

[% author %]

=head1 SEE ALSO

L<[% app %]>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
