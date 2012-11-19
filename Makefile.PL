use strict;
use warnings;
use ExtUtils::MakeMaker;

my $pm =   'lib/Catalyst/View/GD/Thumbnail.pm';
my $bugs = 'https://rt.cpan.org/Public/Dist/Display.html?Name=Catalyst-View-GD-Thumbnail';

WriteMakefile (
    NAME => 'Catalyst::View::GD::Thumbnail',
    VERSION_FROM => $pm,
    ABSTRACT_FROM => $pm,
    AUTHOR => 'Nick Logan <ug@skunkds.org>',
    LICENSE => 'perl',
    PREREQ_PM => {
	'Image::Info'		=> 0,
	'Image::Resize'	=> 0,
	'List::Util'		=> 0,
    },
    BUILD_REQUIRES => {
	'Test::More'		=> 0,
    },
    META_MERGE => {
        resources => {
            bugtracker => "$bugs",
        },
    },
);
