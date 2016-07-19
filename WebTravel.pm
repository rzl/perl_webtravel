package WebTravel;

use strict;
use warnings;
use utf8;

use Carp ();
use Mojo::Base -base;
use Mojo::Log;
use Mojo::UserAgent;
use WebTravel::Plugins;

#use WebTravel::Downloader;
#use WebTravel::Configs;
#use WebTravel::Publish;



has status => sub{{}};
has agent => sub{{}};;
has url_list => '';
has max_conn => '4';
has plugins  => sub { WebTravel::Plugins->new };
has log => sub { Mojo::Log->new};
has helpers => sub { {} };

sub AUTOLOAD {
  my $self = shift;
 
  my ($package, $method) = our $AUTOLOAD =~ /^(.+)::(.+)$/;
  Carp::croak "Undefined subroutine &${package}::$method called"
    unless Scalar::Util::blessed $self && $self->isa(__PACKAGE__);
 
  # Call helper with current controller
  Carp::croak qq{Can't locate object method "$method" via package "$package"}
    unless my $helper = $self->get_helper($method);
  return $self->$helper(@_);
}


sub start{
	my $s=shift;
	$s->log->info('has been start');
}
sub plugin {
  my $self = shift;
  $self->plugins->register_plugin(shift, $self, @_);
}
sub helper { shift->add_helper(@_) }

sub add_helper {
  my ($self, $name, $cb) = @_;
  $self->helpers->{$name} = $cb;
  #delete $self->{proxy};
  return $self;
}

sub get_helper {
  my ($self, $name) = @_;
 
  if (my $h = $self->helpers->{$name}) { return $h }
 
}

1;