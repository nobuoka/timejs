use strict;
use warnings;
use Path::Tiny;
#use lib glob path (__FILE__)->parent->parent->child ('t_deps/modules/*/lib');
use Web::URL;
use Web::Driver::Client::Connection;

my $test_wd_url_str = $ENV{TEST_WD_URL};
my $WD_URL = Web::URL->parse_string ($test_wd_url_str);

my $c;
my $wd = Web::Driver::Client::Connection->new_from_url ($WD_URL);
$wd->new_session (desired => {})->then (sub {
  my $session = $_[0];
  return $session->go (Web::URL->parse_string (q<file:///contents/test/time.tests.html>))->then (sub {
    return $session->execute (q{
      var elems = document.querySelectorAll("#qunit-tests > li");
      return '1..' + elems.length + "\n" + Array.prototype.map.call(elems, function (e, i) {
        var testNumber = i + 1;
        return e.classList.contains("pass") ?
            "ok " + testNumber :
            "not ok " + testNumber + " - " + e.textContent.replace(/\n/g, " ");
      }).join("\n");
    });
  })->then (sub {
    my $res = $_[0];
    my $value = $res->json->{value};
    print $value;
  })->catch (sub {
    my $error = $_[0];
    warn $error;
  })->then (sub {
    return $session->close;
  });
})->catch (sub {
  my $error = $_[0];
  warn $error;
})->then (sub {
  my $p = $wd->close;
  undef $wd;
  return $p;
})->to_cv->recv;
