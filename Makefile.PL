use inc::Module::Install;

name          ( 'Email-Send-Test'                   );
abstract      ( 'Email::Send mailer for use in testing' );
author        ( 'Adam Kennedy<cpan@ali.as>'         );
version_from  ( 'lib/Email/Send/Test.pm'            );
license       ( 'perl'                              );

requires      ( 'perl'                 => '5.005'   );
requires      ( 'Email::Send'          => '1.42'    );

build_requires( 'Test::More'           => '0.47'    );
build_requires( 'File::Spec'           => '0.82'    );

auto_install();

&WriteAll;
