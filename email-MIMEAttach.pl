#!/usr/bin/perl
use MIME::Lite;
 
$to = 'abcd@gmail.com';
$cc = 'efgh@mail.com';
$from = 'webmaster@yourdomain.com';
$subject = 'Test Email';
$message = 'This is test email sent by Perl Script';

$msg = MIME::Lite->new(
                 From     => $from,
                 To       => $to,
                 Cc       => $cc,
                 Subject  => $subject,
                 Type     => 'multipart/mixed'
                 );
                 
# Add your text message.
$msg->attach(Type         => 'text',
             Data         => $message
             );
            
# Specify your file as attachement.
$msg->attach(Type         => 'image/gif',
             Path         => '/tmp/logo.gif',
             Filename     => 'logo.gif',
             Disposition  => 'attachment'
            );       
$msg->send;
print "Email Sent Successfully\n";