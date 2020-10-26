# Plugin for Foswiki - The Free and Open Source Wiki, http://foswiki.org/
#
# LazyLoadPlugin is Copyright (C) 2011-2020 Michael Daum http://michaeldaumconsulting.com
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details, published at
# http://www.gnu.org/copyleft/gpl.html

package Foswiki::Plugins::LazyLoadPlugin;

use strict;
use warnings;

use Foswiki::Func ();
use Foswiki::Plugins::JQueryPlugin ();

our $VERSION = '3.00';
our $RELEASE = '26 Oct 2020';
our $SHORTDESCRIPTION = 'Deferred loading of images';
our $NO_PREFS_IN_TOPIC = 1;
our $doneInit;
our $startToken = "\2";
our $endToken = "\3";
our $placeholder;

sub initPlugin {

  if (Foswiki::Func::getContext()->{static}) {
    return 1;
  }

  $placeholder = "$Foswiki::cfg{PubUrlPath}/$Foswiki::cfg{SystemWebName}/LazyLoadPlugin/white.gif";
  $doneInit = 0;

  Foswiki::Plugins::JQueryPlugin::registerPlugin("LazyLoad", "Foswiki::Plugins::LazyLoadPlugin::Core");

  Foswiki::Func::registerTagHandler("STARTLAZYLOAD", sub {
    unless ($doneInit) {
      Foswiki::Plugins::JQueryPlugin::createPlugin("LazyLoad");
      $doneInit = 1;
    }

    return $startToken;
  });

  Foswiki::Func::registerTagHandler("ENDLAZYLOAD", sub {
    return $endToken;
  });


  return 1;
}

sub completePageHandler {
  # my ( $text, $topic, $web, $meta ) = @_;

  $_[0] =~ s/$startToken(.*?)$endToken/handleLazyLoad($1)/geos;
}

sub handleLazyLoad {
  my $text = shift;

  # repace src with data-original html5 attribute
  $text =~ s/(<img[^>]*?)src=(["'].*?["'])([^>]*?>)/$1src='$placeholder' class='lazyload' loading='lazy' data-src=$2$3/g;

  return $text;
}

1;
