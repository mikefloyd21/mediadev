$j = jQuery.noConflict();

$j(document).ready(function () {
    cloneTableHeader();
	   
    $j(window)
	  .scroll(UpdateTableHeaders)
	  .trigger("scroll");

    $j(window)
      .resize(cloneTableHeader);
});

function UpdateTableHeaders() {
   $j(".persist-area").each(function() {
   
       var el             = $j(this),
           offset         = el.offset(),
           scrollTop      = $j(window).scrollTop(),
           floatingHeader = $j(".floatingHeader", this),
           floatingButtonHeader = $j(".floatingButtonHeader")
       

       if ((scrollTop + 35 > offset.top) && (scrollTop < offset.top + el.height())) {
           floatingHeader.show();
           floatingButtonHeader.show();
       } else {
           floatingHeader.hide();
           floatingButtonHeader.hide();
       };
   });
}

function cloneTableHeader() {
   var clonedHeaderRow;

   $j(".persist-area").each(function() {
       var clonedHeaderRow = $j(".persist-header", this);
       var floatingHeader;
       var floatingButtonHeader = $j(".floatingButtonHeader");

       if($j(".floatingHeader").length) {
           floatingHeader = $j(".floatingHeader");

           floatingHeader.children().css("width", function(i, val){
              return $j(clonedHeaderRow).children().eq(i).width();
           });
           
           if(floatingHeader.width() > clonedHeaderRow.width()){
               $j(".blist th.last").css("width", $j(".blist th.last").width() - 1);
           } else if (floatingHeader.width() < clonedHeaderRow.width()) {
               $j(".blist th.last").css("width", $j(".blist th.last").width() + 1);
           }
       } else {
           floatingHeader = clonedHeaderRow.clone();
           clonedHeaderRow
             .before(floatingHeader)
             .addClass("floatingHeader");

           floatingHeader.children().css("width", function(i, val){
              return $j(clonedHeaderRow).children().eq(i).css("width", val);
           });

           if(floatingHeader.width() > clonedHeaderRow.width()){
               $j(".blist th.last").css("width", $j(".blist th.last").width() - 1);
           } else if (floatingHeader.width() < clonedHeaderRow.width()) {
               $j(".blist th.last").css("width", $j(".blist th.last").width() + 1);
           }
       }

       floatingButtonHeader.css("width", floatingHeader.width() + 1);
   });
}