var displayImage = function(event, id) {
	var image = id;
	image.src = URL.createObjectURL(event.target.files[0]);
};
