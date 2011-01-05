#!/usr/bin/perl

use strict;
use warnings FATAL => 'all';
use lib qw( t/lib );

use Test::More 'no_plan';

# application loads
BEGIN { use_ok "Test::WWW::Mechanize::Catalyst::AJAX" => "TestAppM2M" }
my $mech = Test::WWW::Mechanize::Catalyst::AJAX->new;

my $default_album_page = {
    'total' => 5,
    'rows'  => [
        {
            'artist_albums' => [ 'Artist: id(1)' ],
            'id'            => 1,
            'title'         => 'DJ Mix 1',
            'recorded'      => '1989-01-02',
            'deleted'       => 1
        },
        {
            'artist_albums' => [ 'Artist: id(1)' ],
            'id'            => 2,
            'title'         => 'DJ Mix 2',
            'recorded'      => '1989-02-02',
            'deleted'       => 1
        },
        {
            'artist_albums' => [ 'Artist: id(2)' ],
            'id'            => 3,
            'title'         => 'DJ Mix 3',
            'recorded'      => '1989-03-02',
            'deleted'       => 1
        },
        {
            'artist_albums' => [],
            'id'            => 4,
            'title'         => 'Pop Songs',
            'recorded'      => '2007-05-30',
            'deleted'       => 0
        },
        {
            'artist_albums' => [ 'Artist: id(3)' ],
            'id'            => 5,
            'title'         => 'Greatest Hits',
            'recorded'      => '2002-05-21',
            'deleted'       => 0
        }
    ]
};

my $default_artist_page = {
    'total' => 3,
    'rows'  => [
        {
            'artist_albums' => [ 'Album: id(1)', 'Album: id(2)' ],
            'pseudonym'     => 'Alpha Artist',
            'forename'      => 'Mike',
            'id'            => 1,
            'born'          => '1970-02-28',
            'surname'       => 'Smith'
        },
        {
            'artist_albums' => [ 'Album: id(3)' ],
            'pseudonym'     => 'Band Beta',
            'forename'      => 'David',
            'id'            => 2,
            'born'          => '1992-05-30',
            'surname'       => 'Brown'
        },
        {
            'artist_albums' => [ 'Album: id(5)' ],
            'pseudonym'     => 'Gamma Group',
            'forename'      => 'Adam',
            'id'            => 3,
            'born'          => '1981-05-10',
            'surname'       => 'Smith'
        }
    ]
};

my $default_m2m_page = {
          'rows' => [
                      {
                        'album_id' => 'Album: id(1)',
                        'artist_id' => 'Artist: id(1)'
                      },
                      {
                        'album_id' => 'Album: id(2)',
                        'artist_id' => 'Artist: id(1)'
                      },
                      {
                        'album_id' => 'Album: id(3)',
                        'artist_id' => 'Artist: id(2)'
                      },
                      {
                        'album_id' => 'Album: id(5)',
                        'artist_id' => 'Artist: id(3)'
                      }
                    ],
          'total' => 4
        };


$mech->ajax_ok( '/site/default/schema/dbic/source/album/list', {}, $default_album_page, 'album no args' );
$mech->ajax_ok( '/site/default/schema/dbic/source/artist/list', {}, $default_artist_page, 'artist no args' );

$mech->ajax_ok( '/site/default/schema/dbic/source/artist_album/list', {}, $default_m2m_page, 'artist_album no args' );

__END__
