use strict;
use warnings;
use utf8;
use Mojo::Base -base;
use Mojo::Log;
use WebTravel::Downloader;


has status => sub{{}};
has agent => sub{{}};;
has base_url => '';
has log => sub { Mojo::Log->new };

