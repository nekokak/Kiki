use Kamui;
use Kiki::Container;
use Path::Class;

my $home = container('home');

return +{
    title => 'your wiki title',
    view => {
        mt => +{
            path => $home->file('assets/tmpl')->stringify,
        },
    },
    datasource => +{
        dsn      => 'dbi:mysql:kiki',
        username => 'user',
        password => 'pass',
    },
    validator_message => +{
        param => +{
            title => 'タイトル',
            body  => '本文',
        },
        function => +{
            not_null => '[_1]が空です',
        },
        message => +{
            'foo.bar' => 'fooがbarですね',
        },
    },
};