jQuery(function($) {

  var defaults = {
    effect: "fadeIn"
  };

  $(".jqLazyLoad:not(.jqInitedLazyLoad)").livequery(function() {
    var $this = $(this), 
        opts = $.extend({}, defaults, $this.metadata());

    // placeholder must match the one used in perl handler
    opts.placeholder = foswiki.getPreference("PUBURLPATH") + "/" +
                 foswiki.getPreference("SYSTEMWEB") + "/LazyLoadPlugin/img/white.gif",

    $this.addClass("jqInitedLazyLoad");
    $this.find("img").lazyload(opts);
  });
});
