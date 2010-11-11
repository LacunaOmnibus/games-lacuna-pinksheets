package Games::Lacuna::PinkSheets::Web::Controller::Root;
use Moose;
BEGIN { extends 'Catalyst::Controller::REST' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(
    default => 'text/html',
    map     => {
        'text/html' => [ 'View', 'TT' ],
        'text/xml'  => undef
    },
    namespace => '',
);

sub index : Path('/') ActionClass('REST') {
}

sub index_GET {
    my ( $self, $c ) = @_;
    $self->status_ok(
        $c,
        entity => {
            ask_items    => $c->model('Kioku')->ask_items,
            offer_items  => $c->model('Kioku')->offer_items,
            recent_items => $c->model('Kioku')->recent_items,
        }
    );
}

sub default {
    my ( $self, $c ) = @_;
    $c->response->body('Page not found');
    $c->response->status(404);

}

sub auto : Private {
    my ( $self, $c, @args ) = @_;

    # if ( my $sid = $c->req->params->{SID} ) {
    #     if ( my $session_data = $c->get_session_data("session:$sid") ) {
    #         if ( my $user_data = $session_data->{__user} ) {
    #             delete $c->req->params->{SID};
    #             $c->authenticate(
    #                 {
    #                     username => $user_data->{email},
    #                     password => $user_data->{password}
    #                 }
    #             );
    #         }
    #     }
    # }

    return 1;
}
1;
__END__
