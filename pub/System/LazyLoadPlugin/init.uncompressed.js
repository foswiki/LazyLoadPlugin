jQuery(function($) {
  if ("loading" in HTMLImageElement.prototype) {
    //console.log("Native support for lazy loading of images");
    $(".lazyload").each(function() {
      this.src= this.dataset.src;
    });
  } else {
    console.warn("No native support for lazy loading of images. Using javascript.");
    var script = document.createElement("script");
    script.src = foswiki.getPubUrlPath()+"/System/LazyLoadPlugin/lazysizes.js";
    document.body.appendChild(script);
  }
});
