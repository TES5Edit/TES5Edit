// JavaScript Document
$(document).ready(function() {
	$('.carousel').jCarouselLite({
		btnNext: '.carousel-next', btnPrev: '.carousel-prev', visible: 1, scroll: 1, mouseWheel: true
	});
});

$(document).ready(function() {
    var ctrl = $('.ctrl');

	ctrl.click(function() {
		toggle_one(this);
    });
});

function toggle_one(item) {
	var container = $(item).parent('div');
	var content = $(container).children('div.content');
	content.stop();

	content.slideToggle(300);
	$(item).toggleClass("inactive");
	container.toggleClass("inactive");
	container.children('.ctrl-all').toggle();
}

function toggle_all(button) {
	var value = $(button).text();
	//alert(value);
	if (value === "Expand All") {
		$(button).text("Collapse All");
	} else {
		$(button).text("Expand All");
	}
	var sections = $(button).siblings('div');
	$.each(sections, function(i, section) {
		$(this).children('div.content');
		$(this).children('div.content').stop(true, true).slideToggle(300);
		$(this).toggleClass('inactive');
		$(this).children('.ctrl').toggleClass('inactive');
		$(this).children('.ctrl-all').toggle();
	});
}
