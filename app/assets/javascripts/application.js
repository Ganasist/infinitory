// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require gmaps-autocomplete 
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .


$(document).ready(function() {
	if (gon)  {
		var longitude = gon.longitude,
		latitude = gon.latitude;
	} else {
		var longitude = null,
				latitude = null;
	}
	
	defaultOptions = {
	  mapElem: "#gmaps-canvas", 
	  zoomLevel: 17, 
	  mapType: google.maps.MapTypeId.ROADMAP,
	  pos: [latitude, longitude],
	  inputField: '#gmaps-input-address',
	  errorField: '#gmaps-error',
	  debugOn: false
	};

  GmapsAutoComplete.init(defaultOptions);
  GmapsAutoComplete.autoCompleteInit();
});