package Email::Send::Test;

=pod

=head1 NAME

Email::Send::Test - Captures emails sent via Email::Send for testing

=head1 SYNOPSIS

  # Load as normal
  use Email::Send;
  
  # Send the email
  send Test => $message;
  
  # Check something was sent
  is( scalar(Email::Send::Test->emails), 1, 'Sent 1 email' );
  
  # Check the contents (using the variable directly)
  isa_ok( $Email::Send::Test::emails[0], 'Email::MIME' );
  
  # Reset the variable (OO and directly)
  Email::Send::Test->clear;
  @Email::Send::Test::emails = ();

=head1 DESCRIPTION

Email::Send::Test is a module for testing applications that use Email::Send
to send email. In particular, it kind of assumes that you use some sort of
configuration file to specify the "channel" to dispatch mail to, or
something else that can be easily overloaded or altered in the test script.

=head2 How does it Work

Email::Send::Test is simple a trap. As emails come in, it just puts them
onto an array totally intact as it was given them. If you send one email,
there will be one in the trap. If you send 20, there will be 20, and so
on.

A typical test will involve doing some task that SHOULD trigger an email,
and then checking in the trap to see if the application did, in fact, try
to send out the email.

If you wish you can pull the emails out the trap and examine them. If you
only care that something got sent you can simply clear the trap and move
on to the next test.

=head2 The Email Trap

The email trap is simple a global array, C<@Email::Send::Test::emails>.
When you send an email, it is simply pushed onto the array. You can access
the array directly if you wish, or use the methods provided.

=head1 METHODS

=cut

use strict;

use vars qw{$VERSION @emails};
BEGIN {
	$VERSION = '0.02';
	@emails  = ();
}

=pod

=head2 send $message

As for every other Email::Send mailer, C<send> takes the message to be sent.

However, in our case there are no arguments of any value to us, and so they
are ignored.

It is worth nothing that we do NOTHING to examine the email. If we are
passed C<undef> for example, we simply push C<undef> onto the trap. In this
manner, you can see exactly what was sent.

Always returns true.

=cut

sub send {
	push @emails, shift;
	1;
}

=pod

=head2 emails

For the OO entusiasts, the C<emails> method simply returns, as a list, the
contents of the email trap.

In scalar context, returns the number of items in the trap.

=cut

sub emails {
	wantarray ? @emails : scalar @emails;
}

=pod

=head2 clear

The C<clear> method simply resets the trap, emptying it.

Always returns true

=cut

sub clear {
	@emails = (); 1;
}

1;

=pod

=head1 SUPPORT

All bugs should be filed via the CPAN bug tracker at

L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Email%3A%3ASend%3A%3ATest>

For other issues, or commercial enhancement or support, contact the author.

=head1 AUTHORS

Adam Kennedy (Maintainer), L<http://ali.as/>, cpan@ali.as

=head1 COPYRIGHT

Copyright (c) 2004 Adam Kennedy. All rights reserved.
This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut
