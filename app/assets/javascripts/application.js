//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require best_in_place
//= require best_in_place.purr
//= require twitter/bootstrap
//= require_tree


$('#einstein_modal').modal({
        backdrop: true,
        keyboard: true,
        show: false
    }).css({
        width: '320px',
        height: '600px',
        padding: '10px'
    });

$('#nerd_modal').modal({
        backdrop: true,
        keyboard: true,
        show: false
    }).css({
        width: '280px',
        height: '550px',
        padding: '10px'
    });