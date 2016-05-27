"use strict";
jQuery(function($) {

  var defaults = {
    effect: "fadeIn",
    skip_invisible: false
  };

  $(".jqLazyLoad:not(.jqInitedLazyLoad)").livequery(function() {
    var $this = $(this), 
        opts = $.extend({}, defaults, $this.data(), $this.metadata());

    $this.addClass("jqInitedLazyLoad");
    $this.find("img").lazyload(opts);
  });
});
