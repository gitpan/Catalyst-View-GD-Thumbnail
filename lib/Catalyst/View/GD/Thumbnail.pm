package Catalyst::View::GD::Thumbnail;

use warnings;
use strict;
use parent 'Catalyst::View';
use Image::Info qw/image_type/;
use Image::Resize;
use List::Util qw/min max/;

our $VERSION = '0.11';

sub process {
  my ($self, $c) = @_;
  my $file = $c->stash->{thumbnail}->{image};
  my $x = $c->stash->{thumbnail}->{x};
  my $y = $c->stash->{thumbnail}->{y};
  
  if(!defined $c->stash->{thumbnail}->{quality}) {
		$c->stash->{thumbnail}->{quality} = "";
  }
  
  my $quality = $c->stash->{thumbnail}->{quality};
  my $mime = image_type($file)->{file_type};  
  my $resize = Image::Resize->new($file);
  my $source_aspect = $resize->width / $resize->height;
  $x  ||= $y * $source_aspect;
  $y  ||= $x / $source_aspect;
  my $thumbnail = $resize->resize($x,$y);
  
	if($mime eq 'BMP') {
		$thumbnail = $thumbnail->bmp;
	}
	elsif($mime eq 'GIF') {
		$thumbnail = $thumbnail->gif;
	}
	elsif($mime eq 'JPEG') {
		if($quality eq "" || $quality > 100 || $quality < 0) {
			$thumbnail = $thumbnail->jpeg;
		}
		else {
			$thumbnail = $thumbnail->jpeg($quality);
		}
	}
	elsif($mime eq 'PNG') {
		$thumbnail = $thumbnail->png;
		if($quality eq "" || $quality > 9 || $quality < 0) {
			$thumbnail = $thumbnail->png;
		}
		else {
			$thumbnail = $thumbnail->png($quality);
		}
	} 
	elsif($mime eq 'X-XBITMAP') {
		$thumbnail = $thumbnail->xbm;
	}  
	elsif($mime eq 'X-XPIXMAP') {
		$thumbnail = $thumbnail->xpm;
	}  
	else {
		my $error = qq/Unsupported image format/;
		$c->log->error($error);
		$c->error($error);
		return 0;  
	}
	  
  $c->response->content_type($mime);
  $c->response->body($thumbnail);    
}

1;

__END__

=encoding utf8

=head1 NAME

Catalyst::View::GD::Thumbnail - Catalyst view to resize images for thumbnails

=cut

=head1 SYNOPSIS

    Create a thumbnail view:

	script/myapp_create view Thumbnail Thumbnail

    Then in your controller:

	sub thumbnail :Local :Args(1) {
 		my ($self, $c, $image_file_path) = @_;

		$c->stash->{x}     = 100;    
		# Create a 100px wide thumbnail

		#or

		$c->stash->{y}     = 100;    
		# Create a 100px tall thumbnail

            	$c->stash->{image} = $image_file_path;        
            	$c->forward('View::Thumbnail');
	}


=head1 DESCRIPTION

Catalyst::View::GD::Thumbnail resizes images to produce thumbnails, with options to set the desired x or y
dimensions. Uses the GD image library for those who are already using something more advanced than Imager.

=head2 Options

The view is controlled by setting the following values in the stash:

=over

=item image

Contains the file path for the full-size source image.

This is a mandatory option.

=item x

The width (in pixels) of the thumbnail.

This is optional, but at least one of the C<x> or C<y> parameters must be set.

=item y

The height (in pixels) of the thumbnail.

This is optional, but at least one of the C<x> or C<y> parameters must be set.

=back

=head2 Image formats

The generated thumbnails will always be produced in the same format (PNG, JPG, etc)
as the source image.

Catalyst::View::GD::Thumbnail uses the L<Image::Resize> module to crop and resize images,
so it accept any image format supported by I<Image::Resize>: bmp, gif, jpeg, png, xbm, xpm.

Please see the L<Image::Resize> documentation for more details and installation notes.

=head1 BUGS

Please report any bugs or feature requests to C<bug-catalyst-view-thumbnail at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Catalyst-View-GD-Thumbnail>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 AUTHOR

Nick Logan (ugexe) <F<ug@skunkds.com>>

=head1 LICENSE AND COPYRIGHT

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.