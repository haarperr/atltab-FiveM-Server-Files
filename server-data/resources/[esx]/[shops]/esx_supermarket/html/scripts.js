var prices = {}
var maxes = {}
var zone = null

// Partial Functions
function closeMain() {
	$("body").css("display", "none");
}
function openMain() {
	$("body").css("display", "block");
}
function closeAll() {
	$(".body").css("display", "none");
}

$(".close").click(function(){
	$.post('http://esx_supermarket/quit', JSON.stringify({}));
});

// added by Zeref
// $(document).keyup(function (e) {
// 		if (e.keyCode == 27) {
// 			$.post('http://esx_supermarket/quit', JSON.stringify({}));
// 		}
// });


// Listen for NUI Events
window.addEventListener('message', function (event) {

	var item = event.data;

	// Open & Close main window
	if (item.message == "show") {
		if (item.clear == true){
			$( ".home" ).empty();
			prices = {}
			maxes = {}
			zone = null
		}
		openMain();
	}

	if (item.message == "hide") {
		closeMain();
	}
	
	if (item.message == "add"){
		$( ".home" ).append('<div class="card">' +
				'<span class="titre">' + item.label + '</span>' +
					'<img src="img/' + item.item + '.png" class="tswira" alt="' + item.label + '">' + 
					'<div class="container">' + 
						'<div class="purchase">' + 
							'<div class="price">' + item.price + ' DH' + '</div>' +
							'<div class="buy" name="' + item.item + '">Acheter</div>' + 
						'</div>' +
					'</div>' +
				'</div>');
		prices[item.item] = item.price;
		maxes[item.item] = item.max;
		zone = item.loc;
	}
});

$(".home").on("click", ".buy", function() {
	var $button = $(this);
	var $name = $button.attr('name')
	var $count = 1;
	$.post('http://esx_supermarket/purchase', JSON.stringify({
		item: $name,
		count: $count,
		loc: zone
	}));
});
