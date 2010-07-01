package Kiki::Web::Dispatcher;
use Kamui::Web::Dispatcher;

on '/' => run {
    return 'Root', 'index', FALSE, +{};
};

on '/(add|list|search)' => run {
    return 'Root', $1, FALSE, +{};
};

on '/edit/(.+)' => run {
    return 'Root', 'edit', FALSE, +{rid => $1};
};

on '/(.+)' => run {
    return 'Root', 'show', FALSE, +{rid => $1};
};

1;
