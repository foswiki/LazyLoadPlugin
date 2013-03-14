# Plugin for Foswiki - The Free and Open Source Wiki, http://foswiki.org/
#
# MyEmptyPlugin is Copyright (C) 2011 Michael Daum http://michaeldaumconsulting.com
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

our $VERSION = '1.20';
our $RELEASE = '1.20';
our $SHORTDESCRIPTION = 'deferred loading of images';
our $NO_PREFS_IN_TOPIC = 1;
our $doneInit;
our $translationToken;
our $placeholder;

sub initPlugin {

  $translationToken = "\2";
  $placeholder = "$Foswiki::cfg{PubUrlPath}/$Foswiki::cfg{SystemWebName}/LazyLoadPlugin/img/white.gif";
  $doneInit = 0;

  Foswiki::Plugins::JQueryPlugin::registerPlugin("LazyLoad", "Foswiki::Plugins::LazyLoadPlugin::Core");

  Foswiki::Func::registerTagHandler("STARTLAZYLOAD", sub {
    unless ($doneInit) {
      Foswiki::Plugins::JQueryPlugin::createPlugin("LazyLoad");
      $doneInit = 1;
    }

    return $translationToken."<div class='jqLazyLoad'>";
  });

  Foswiki::Func::registerTagHandler("ENDLAZYLOAD", sub {
    return "</div>".$translationToken;
  });


  return 1;
}

sub completePageHandler {
  # my ( $text, $topic, $web, $meta ) = @_;

  $_[0] =~ s/$translationToken(<div class='jqLazyLoad'>)(.*?)(<\/div>)$translationToken/$1.handleLazyLoad($2).$3/geos;
}

sub handleLazyLoad {
  my $text = shift;


  # repace src with data-original html5 attribute
  $text =~ s/(<img[^>]*?)src=(["'].*?["'])([^>]*?>)/$1src='$placeholder' data-original=$2$3/g;

  return $text;
}

1;
