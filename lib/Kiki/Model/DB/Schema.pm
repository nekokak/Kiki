package Kiki::Model::DB::Schema;
use DBIx::Skinny::Schema;
use Kiki::Container qw/api/;

install_common_trigger pre_insert => sub {
    my ($self, $args, $table) = @_;
    $args->{rid}        ||= api('String')->gen_unique($self, $table, 'rid', '[A-Za-z0-9]{10}');
    $args->{created_at} ||= api('DateTime')->now;
};

install_table page => schema {
    pk 'id';
    columns qw/id rid title body created_at updated_at/;
};

install_utf8_columns qw/title body name/;

install_inflate_rule '^.+_at$' => callback {
    inflate {
        api('DateTime')->inflate_datetime(+shift);
    };
    deflate {
        api('DateTime')->deflate_datetime(+shift);
    };
};

1;

