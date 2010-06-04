use Kiki::Web::Handler;
use Kiki::Container;
use Plack::Builder;
my $app = Kiki::Web::Handler->new;
$app->setup;

my $home = container('home');
builder {
   enable "Plack::Middleware::Static",
           path => qr{^/(images|js|css)/},
           root => $home->file('assets/htdocs')->stringify;

   $app->handler;
};

