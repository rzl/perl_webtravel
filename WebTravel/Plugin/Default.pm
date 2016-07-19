package WebTravel::Plugin::Default;
use Mojo::Base 'WebTravel::Plugin';

sub register{
	my ($self, $app, $conf) = @_;
	$app->log->info("load plugin success");
}

1;