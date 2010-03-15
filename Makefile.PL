use inc::Module::Install;

name     'Catalyst-View-GD-Thumbnail';
all_from 'lib/Catalyst/View/GD/Thumbnail.pm';
author   q{Nick Logan (ugexe) <nik_517@yahoo.com>};
license  'perl';

requires 'parent'          => 0;
requires 'Catalyst::View'  => 0;
requires 'Image::Info'	   => 0;
requires 'Image::Resize'   => 0;
requires 'List::Util'	   => 0;

build_requires 'Test::More';

WriteAll;

