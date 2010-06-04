package Kiki::Web::Handler;
use Kamui::Web::Handler;

use_container 'Kiki::Container';
use_dispatcher 'Kiki::Web::Dispatcher';
use_plugins [qw/Encode FormValidatorLite/];
use_view 'Kamui::View::MT';

1;

