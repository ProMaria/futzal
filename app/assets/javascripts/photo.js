$(document).ready(function() {
      
    var selectTag = $("#tour_id");
	selectTag.bind('click  touchstart', function(){

		//console.log($(this).children("option:selected").val());
		$.ajax({
		  type: 'GET',
		  
		  url: '/photo/'+$(this).children("option:selected").val(),
		  dataType: 'script'		  
		});

		// $('#list').html($("<%= j render(:partial => 'list', :locals => {:f => "+selectTag.attr('data')+'}) %>")';
	});
});
