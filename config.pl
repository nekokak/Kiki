use Kamui;
use Kiki::Container;
use Path::Class;

my $home = container('home');

return +{
    title => 'your wiki title here.',
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
            'update.conflict' => '更新が衝突しました！やりなおしてください',
        },
    },
    users => +{
        nekokak => 'uhuhu',
    },
};
