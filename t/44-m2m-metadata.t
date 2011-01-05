#!/usr/bin/perl

use strict;
use warnings FATAL => 'all';
use lib qw( t/lib );

use Test::More 'no_plan';

# application loads
BEGIN { use_ok "Test::WWW::Mechanize::Catalyst" => "TestAppM2M" }
my $mech = Test::WWW::Mechanize::Catalyst->new;

# get metadata for the album table
$mech->get_ok( '/site/default/schema/dbic/source/album/dumpmeta', 'Get album autocrud metadata' );
is( $mech->ct, 'application/json', 'Metadata content type' );

my $response = JSON::from_json( $mech->content );

# get metadata for the artist_album table
$mech->get_ok( '/site/default/schema/dbic/source/artist_album/dumpmeta', 'Get artist_album autocrud metadata' );
is( $mech->ct, 'application/json', 'Metadata content type' );

my $response_aa = JSON::from_json( $mech->content );

use Data::Dumper;
print STDERR Dumper $response_aa;

my $expected = {
    'model'      => 'AutoCRUD::DBIC::Album',
    'table2path' => {
        'Album'        => 'album',
        'Artist Album' => 'artist_album',
        'Artist'       => 'artist'
    },
    'tab_order' => { 'AutoCRUD::DBIC::Album' => 1 },
    'main'      => {
        'mfks'    => { 'artist_albums' => 'Artists' },
        'pk'      => ['id'],
        'moniker' => 'Album',
        'col_order' => [ 'id', 'title', 'recorded', 'deleted' ],
        'm2m'   => { 'artist_albums' => 'artist_id' },
        'title' => 'Album',
        'path'  => 'album',
        'cols'  => {
            'deleted' => {
                'required'    => 1,
                'extjs_xtype' => 'checkbox',
                'editable'    => 1,
                'heading'     => 'Deleted'
            },
            'recorded' => {
                'required'    => 1,
                'extjs_xtype' => 'datefield',
                'editable'    => 1,
                'heading'     => 'Recorded'
            },
            'title' => {
                'required' => 1,
                'editable' => 1,
                'heading'  => 'Title'
            },
            'id' => {
                'required'    => 1,
                'extjs_xtype' => 'numberfield',
                'editable'    => 0,
                'heading'     => 'Id'
            }
        }
    },
    'db2path'      => { 'Dbic' => 'dbic' },
    'dbpath2model' => { 'dbic' => 'AutoCRUD::DBIC' },
    'table_info'   => {
        'AutoCRUD::DBIC::Album' => {
            'mfks'    => { 'artist_albums' => 'Artists' },
            'pk'      => ['id'],
            'moniker' => 'Album',
            'col_order' => [ 'id', 'title', 'recorded', 'deleted' ],
            'm2m'   => { 'artist_albums' => 'artist_id' },
            'title' => 'Album',
            'path'  => 'album',
            'cols'  => {
                'deleted' => {
                    'required'    => 1,
                    'extjs_xtype' => 'checkbox',
                    'editable'    => 1,
                    'heading'     => 'Deleted'
                },
                'recorded' => {
                    'required'    => 1,
                    'extjs_xtype' => 'datefield',
                    'editable'    => 1,
                    'heading'     => 'Recorded'
                },
                'title' => {
                    'required' => 1,
                    'editable' => 1,
                    'heading'  => 'Title'
                },
                'id' => {
                    'required'    => 1,
                    'extjs_xtype' => 'numberfield',
                    'editable'    => 0,
                    'heading'     => 'Id'
                }
            }
        }
    },
    'path2model' => {
        'dbic' => {
            'artist'       => 'AutoCRUD::DBIC::Artist',
            'artist_album' => 'AutoCRUD::DBIC::ArtistAlbum',
            'album'        => 'AutoCRUD::DBIC::Album'
        }
    }
};

my $m2m_table_expected = {
          'site_conf' => {
                           'create_allowed' => 'yes',
                           'delete_allowed' => 'yes',
                           'frontend' => 'full-fat',
                           'update_allowed' => 'yes',
                           'dbic' => {
                                       'create_allowed' => 'yes',
                                       'artist' => {
                                                     'create_allowed' => 'yes',
                                                     'col_keys' => {},
                                                     'delete_allowed' => 'yes',
                                                     'frontend' => 'full-fat',
                                                     'update_allowed' => 'yes',
                                                     'columns' => [],
                                                     'hidden' => 'no',
                                                     'headings' => {}
                                                   },
                                       'artist_album' => {
                                                           'create_allowed' => 'yes',
                                                           'col_keys' => {},
                                                           'delete_allowed' => 'yes',
                                                           'frontend' => 'full-fat',
                                                           'update_allowed' => 'yes',
                                                           'columns' => [],
                                                           'hidden' => 'no',
                                                           'headings' => {}
                                                         },
                                       'album' => {
                                                    'create_allowed' => 'yes',
                                                    'col_keys' => {},
                                                    'delete_allowed' => 'yes',
                                                    'frontend' => 'full-fat',
                                                    'update_allowed' => 'yes',
                                                    'columns' => [],
                                                    'hidden' => 'no',
                                                    'headings' => {}
                                                  },
                                       'delete_allowed' => 'yes',
                                       'frontend' => 'full-fat',
                                       'update_allowed' => 'yes',
                                       'hidden' => 'no'
                                     },
                           'hidden' => 'no',
                           '__built' => 1
                         },
          'lf' => {
                    'db2path' => {
                                   'Dbic' => 'dbic'
                                 },
                    'dbpath2model' => {
                                        'dbic' => 'AutoCRUD::DBIC'
                                      },
                    'table_info' => {
                                      'AutoCRUD::DBIC::Album' => {
                                                                   'mfks' => {
                                                                               'artist_albums' => 'Artists'
                                                                             },
                                                                   'pk' => [
                                                                             'id'
                                                                           ],
                                                                   'moniker' => 'Album',
                                                                   'col_order' => [
                                                                                    'id',
                                                                                    'title',
                                                                                    'recorded',
                                                                                    'deleted'
                                                                                  ],
                                                                   'path' => 'album',
                                                                   'title' => 'Album',
                                                                   'm2m' => {
                                                                              'artist_albums' => 'artist_id'
                                                                            },
                                                                   'cols' => {
                                                                               'id' => {
                                                                                         'required' => 1,
                                                                                         'extjs_xtype' => 'numberfield',
                                                                                         'heading' => 'Id',
                                                                                         'editable' => 0
                                                                                       },
                                                                               'title' => {
                                                                                            'required' => 1,
                                                                                            'heading' => 'Title',
                                                                                            'editable' => 1
                                                                                          },
                                                                               'recorded' => {
                                                                                               'required' => 1,
                                                                                               'extjs_xtype' => 'datefield',
                                                                                               'heading' => 'Recorded',
                                                                                               'editable' => 1
                                                                                             },
                                                                               'deleted' => {
                                                                                              'required' => 1,
                                                                                              'extjs_xtype' => 'checkbox',
                                                                                              'heading' => 'Deleted',
                                                                                              'editable' => 1
                                                                                            }
                                                                             }
                                                                 },
                                      'AutoCRUD::DBIC::ArtistAlbum' => {
                                                                         'pk' => [
                                                                                   'artist_id',
                                                                                   'album_id'
                                                                                 ],
                                                                         'moniker' => 'ArtistAlbum',
                                                                         'col_order' => [
                                                                                          'artist_id',
                                                                                          'album_id'
                                                                                        ],
                                                                         'path' => 'artist_album',
                                                                         'title' => 'Artist Album',
                                                                         'cols' => {
                                                                                     'album_id' => {
                                                                                                     'foreign_col' => [
                                                                                                                        'id'
                                                                                                                      ],
                                                                                                     'required' => 1,
                                                                                                     'extjs_xtype' => 'numberfield',
                                                                                                     'heading' => 'Album',
                                                                                                     'editable' => 1,
                                                                                                     'fk_model' => 'AutoCRUD::DBIC::Album',
                                                                                                     'is_fk' => 1,
                                                                                                     'masked_col' => [
                                                                                                                       'album_id'
                                                                                                                     ]
                                                                                                   },
                                                                                     'artist_id' => {
                                                                                                      'foreign_col' => [
                                                                                                                         'id'
                                                                                                                       ],
                                                                                                      'required' => 1,
                                                                                                      'extjs_xtype' => 'numberfield',
                                                                                                      'heading' => 'Artist',
                                                                                                      'editable' => 1,
                                                                                                      'fk_model' => 'AutoCRUD::DBIC::Artist',
                                                                                                      'is_fk' => 1,
                                                                                                      'masked_col' => [
                                                                                                                        'artist_id'
                                                                                                                      ]
                                                                                                    }
                                                                                   }
                                                                       },
                                      'AutoCRUD::DBIC::Artist' => {
                                                                    'mfks' => {
                                                                                'artist_albums' => 'Albums'
                                                                              },
                                                                    'pk' => [
                                                                              'id'
                                                                            ],
                                                                    'moniker' => 'Artist',
                                                                    'col_order' => [
                                                                                     'id',
                                                                                     'forename',
                                                                                     'surname',
                                                                                     'pseudonym',
                                                                                     'born'
                                                                                   ],
                                                                    'path' => 'artist',
                                                                    'title' => 'Artist',
                                                                    'm2m' => {
                                                                               'artist_albums' => 'album_id'
                                                                             },
                                                                    'cols' => {
                                                                                'pseudonym' => {
                                                                                                 'required' => 1,
                                                                                                 'heading' => 'Pseudonym',
                                                                                                 'editable' => 1
                                                                                               },
                                                                                'forename' => {
                                                                                                'required' => 1,
                                                                                                'heading' => 'Forename',
                                                                                                'editable' => 1
                                                                                              },
                                                                                'id' => {
                                                                                          'required' => 1,
                                                                                          'extjs_xtype' => 'numberfield',
                                                                                          'heading' => 'Id',
                                                                                          'editable' => 0
                                                                                        },
                                                                                'born' => {
                                                                                            'required' => 1,
                                                                                            'extjs_xtype' => 'datefield',
                                                                                            'heading' => 'Born',
                                                                                            'editable' => 1
                                                                                          },
                                                                                'surname' => {
                                                                                               'required' => 1,
                                                                                               'heading' => 'Surname',
                                                                                               'editable' => 1
                                                                                             }
                                                                              }
                                                                  }
                                    },
                    'model' => 'AutoCRUD::DBIC::ArtistAlbum',
                    'path2model' => {
                                      'dbic' => {
                                                  'album' => 'AutoCRUD::DBIC::Album',
                                                  'artist_album' => 'AutoCRUD::DBIC::ArtistAlbum',
                                                  'artist' => 'AutoCRUD::DBIC::Artist'
                                                }
                                    },
                    'table2path' => {
                                      'Album' => 'album',
                                      'Artist Album' => 'artist_album',
                                      'Artist' => 'artist'
                                    },
                    'main' => {
                                'pk' => [
                                          'artist_id',
                                          'album_id'
                                        ],
                                'moniker' => 'ArtistAlbum',
                                'col_order' => [
                                                 'artist_id',
                                                 'album_id'
                                               ],
                                'path' => 'artist_album',
                                'title' => 'Artist Album',
                                'cols' => {
                                            'album_id' => {
                                                            'foreign_col' => [
                                                                               'id'
                                                                             ],
                                                            'required' => 1,
                                                            'extjs_xtype' => 'numberfield',
                                                            'heading' => 'Album',
                                                            'editable' => 1,
                                                            'fk_model' => 'AutoCRUD::DBIC::Album',
                                                            'is_fk' => 1,
                                                            'masked_col' => [
                                                                              'album_id'
                                                                            ]
                                                          },
                                            'artist_id' => {
                                                             'foreign_col' => [
                                                                                'id'
                                                                              ],
                                                             'required' => 1,
                                                             'extjs_xtype' => 'numberfield',
                                                             'heading' => 'Artist',
                                                             'editable' => 1,
                                                             'fk_model' => 'AutoCRUD::DBIC::Artist',
                                                             'is_fk' => 1,
                                                             'masked_col' => [
                                                                               'artist_id'
                                                                             ]
                                                           }
                                          }
                              },
                    'tab_order' => {
                                     'AutoCRUD::DBIC::Album' => 2,
                                     'AutoCRUD::DBIC::ArtistAlbum' => 1,
                                     'AutoCRUD::DBIC::Artist' => 3
                                   }
                  }
        };

SKIP: {
        eval { require Lingua::EN::Inflect::Number };

        skip "Lingua::EN::Inflect::Number not installed", 1 if $@;

    is_deeply( $response->{lf}, $expected, 'Metadata is as we expect' );
}

SKIP: {
        eval { require Lingua::EN::Inflect::Number };

        skip "Lingua::EN::Inflect::Number not installed", 1 if $@;

    is_deeply( $response_aa->{lf}, $m2m_table_expected, 'Metadata is as we expect' );
}

#warn $mech->content;
__END__
