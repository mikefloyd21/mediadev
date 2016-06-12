jQuery(document).ready(function ($) {
    currentGoalVal = $(".active_goal_input:first").val();

    function exitGoalDialog(){
	    $(".modal_background").fadeOut();
        $(".error_container").fadeOut();
        $("#goal_input_container").css({
            'background': '#fff',
            'border-left': '5px solid #fff'
        });
	    $("#goal_settings_container").fadeOut(function(){
            $("#goal_input_container input:first").val(currentGoalVal)
	    });
    }

	$(".small_x_button").click(function() {
	   exitGoalDialog();
	});

	$("#cancel_button").click(function() {
	   exitGoalDialog();
	});

	$("#open_lead_goal_button").click(function() {
        currentGoalVal = $("#goal_input_container input:first").val();
	    $(".modal_background").fadeIn();
	    $("#goal_settings_container").fadeIn();
        $("#goal_input_container input:first").focus();
	});

    $("form").submit(function(e) {
        var newMonthGoal = $(".monthGoalInput:first").val();
        var newQuarterGoal = $(".quarterGoalInput:first").val();

        if ($(".active_month_goal_input").length) {
            if (($.isNumeric(newMonthGoal) && Math.floor(newMonthGoal) == newMonthGoal && newMonthGoal >= 0) &&
                ($.isNumeric(newQuarterGoal) && Math.floor(newQuarterGoal) == newQuarterGoal && newQuarterGoal >= 0)) {
                currentGoalVal = newMonthGoal;
                exitGoalDialog();
            } else {
                e.preventDefault();
                $(".error_container").fadeIn();
    
                $("#goal_input_container").css({
                    'background': '#fdf0ee',
                    'border-left': '5px solid #e96955',
                });
            }
        } else {
            if (($.isNumeric(newQuarterGoal) && Math.floor(newQuarterGoal) == newQuarterGoal && newQuarterGoal >= 0) &&
                ($.isNumeric(newMonthGoal) && Math.floor(newMonthGoal) == newMonthGoal && newMonthGoal >= 0)) {
                currentGoalVal = newQuarterGoal;
                exitGoalDialog();
            } else {
                e.preventDefault();
                $(".error_container").fadeIn();
    
                $("#goal_input_container").css({
                    'background': '#fdf0ee',
                    'border-left': '5px solid #e96955',
                });
            }
        }
    });

    $("#goal_input_container input").keyup(function(event){
        if(event.keyCode == 13){
            $(".goal_submit_button").click();
        }
    });
});