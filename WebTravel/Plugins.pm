package WebTravel::Plugins;
use Mojo::Base '-base';
use Mojo::Loader 'load_class';
use Mojo::Util 'camelize';
 
has namespaces => sub { ['WebTravel::Plugin'] };
 
sub load_plugin {
  my ($self, $name) = @_;
 
  # Try all namespaces and full module name
  my $suffix = $name =~ /^[a-z]/ ? camelize $name : $name;
  my @classes = map {"${_}::$suffix"} @{$self->namespaces};
  for my $class (@classes, $name) { return $class->new if _load($class) }
 
  # Not found
  die qq{Plugin "$name" missing, maybe you need to install it?\n};
}
 
sub register_plugin {
  shift->load_plugin(shift)->register(shift, ref $_[0] ? $_[0] : {@_});
}
 
sub _load {
  my $module = shift;
  return $module->isa('WebTravel::Plugin') unless my $e = load_class $module;
  ref $e ? die $e : return undef;
}
 
1;
 