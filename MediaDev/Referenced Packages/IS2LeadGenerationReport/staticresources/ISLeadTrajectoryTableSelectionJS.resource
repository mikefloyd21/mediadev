$j = jQuery.noConflict();

$j(document).ready(function() {
    recalcSelectedTotal();

    $j('.ls_enabled_checkbox:not(:checked)').each(function(i, v) {
        $j(v).closest('tr').fadeTo("fast",0.35);
    });

    $j('.ls_enabled_checkbox').change(function() {
        if(this.checked === false) {
            $j('.all-selection-button').removeClass('active_selection_link');
            $j(this).closest('tr').fadeTo("fast",0.35);
        } else {
            $j('.none-selection-button').removeClass('active_selection_link');
            $j(this).closest('tr').fadeTo("fast",1);
        }
        $j('.lead_source_submit').addClass('active_lead_source_submit');
        recalcSelectedTotal();
    });

    $j('.all-selection-button').click(function() {
        var el = $j(this);

        if(el.hasClass('active_selection_link')) {
            // Do nothing
        } else {
            $j('.all-selection-button').addClass('active_selection_link');
            $j('.lead_source_submit').addClass('active_lead_source_submit');
            selectAll();
            recalcSelectedTotal();
        }
    });

    $j('.none-selection-button').click(function() {
        var el = $j(this);

        if(el.hasClass('active_selection_link')) {
            // Do nothing
        } else {
            $j('.none-selection-button').addClass('active_selection_link');
            $j('.lead_source_submit').addClass('active_lead_source_submit');
            selectNone();
            recalcSelectedTotal();
        }
    });

});

function selectAll() {
    $j('.none-selection-button').removeClass('active_selection_link');
    $j('.ls_enabled_checkbox:not(:checked)').each(function(i, v) {
        $j(v).closest('tr').fadeTo("fast",1);
        $j(v).prop('checked',true);
    });
}

function selectNone() {
    $j('.all-selection-button').removeClass('active_selection_link');
    $j('.ls_enabled_checkbox:checked').each(function(i, v) {
        $j(v).prop('checked',false);
        $j(v).closest('tr').fadeTo("fast",0.35);
    });
}

function recalcSelectedTotal() {
    var lsCount = 0;
    var leadTotalCount = 0;
    $j('.ls_enabled_checkbox:checked').each(function(i, v) {
        lsCount++;
        leadTotalCount += parseInt($j(this).closest('tr').children().eq(2).text());
    });

    $j('.selected-leads-count').text(lsCount);
    $j('.selected-leads-total').text(leadTotalCount);
    if(undefined === currentGoalVal || currentGoalVal <= 0 || currentGoalVal === null) {
        $j('.selected-leads-perc').text(0);
    } else {
        var leadPercent = Math.round(((leadTotalCount / currentGoalVal) * 100) * 10) / 10;
        $j('.selected-leads-perc').text(leadPercent);
    }
}