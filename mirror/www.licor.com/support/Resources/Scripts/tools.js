/*begin selectable tabs*/
function show(evt, products) {
	var i, tabcontent, tablinks;
	tabcontent = document.getElementsByClassName("tabcontent");
	for (i = 0; i < tabcontent.length; i++) {
		tabcontent[i].style.display = "none";
	}
	tablinks = document.getElementsByClassName("tablinks");
	for (i = 0; i < tablinks.length; i++) {
		tablinks[i].className = tablinks[i].className.replace(" active", "");
	}
	document.getElementById(products).style.display = "block";
	evt.currentTarget.className += " active";
}
/*end selectable tabs*/
/*begin sortable table*/
function sortTable() {
	var input, filter, table, tr, td, i;
	input = document.getElementById("sortInput");
	filter = input.value.toUpperCase();
	table = document.getElementById("docsTable");
	tr = table.getElementsByTagName("tr");
	for (i = 0; i < tr.length; i++) {
		td = tr[i].getElementsByTagName("td")[0];
		if (td) {
			if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
				tr[i].style.display = "";
			} else {
				tr[i].style.display = "none";
			}
		}
	}
}
/*end sortable table*/
/*begin filter table*/
function filterTable() {
	var input, filter, table, tr, td, i;
	input = document.getElementById("filterInput");
	filter = input.value.toUpperCase();
	table = document.getElementById("docsTable");
	tr = table.getElementsByTagName("tr");
	for (i = 0; i < tr.length; i++) {
		td = tr[i].getElementsByTagName("td")[2];
		if (td) {
			if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
				tr[i].style.display = "";
			} else {
				tr[i].style.display = "none";
			}
		}
	}
}
/*end filter table*/
/*begin feedback form*/
$(document).ready(function () {

	/* -------------- Feedback Thanks to David Lee on the MadCap Flare Forum for this useful trick-------------- */
	/* Yes click */
	$('.feedback-yes').click(function () {
		/* fade out question, fade in thankyou message */
		$('.feedback-question').fadeOut(function () {
			$('.feedback-reason.yes-thanks').fadeIn();
		});
	});
	/* No click */
	$('.feedback-no').click(function () {
		/* fade out question, fade in thankyou message */
		$('.feedback-question').fadeOut(function () {
			$('.feedback-reason.no').fadeIn();
		});
	});
	/* No - response reasons */
	$('.feedback-reason .option').change(function () {
		/* if any options change, disable checkbox */
		$(this).attr('disabled', true);
	});
});
/*end feedback form*/

/*launches email with "to" "subject" and "body" populated.*/
function emailCurrentPage() {
	window.location.href = "mailto:?subject=" + document.title + "&body=" + escape(window.location.href);
}
/*end email customizations*/
/*hide show citations*/
function showCite() {
	var x = document.getElementById("cite-dropdown");
	if (x.style.display === "block") {
		x.style.display = "none";
	} else {
		x.style.display = "block";
	}
}
/*hide show citations*/
/*begin copy citation*/
function copyCitation(button) {
	// Get the text field
	var copyText = document.getElementById("citation");

	// Select the text field
	copyText.select();
	copyText.setSelectionRange(0, 99999); // For mobile devices

	// Copy the text inside the text field
	navigator.clipboard.writeText(copyText.value);

	// Change button text
	button.textContent = "Copied";
}
/*end copy citation*/

/*begin search selector*/
var divs = ["searchContent", "searchCal"];
var visibleId = null;
function showsearch(id) {
	if (visibleId !== id) {
		visibleId = id;
	}
	hide();
}

function hide() {
	var div, i, id;
	for (i = 0; i < divs.length; i++) {
		id = divs[i];
		div = document.getElementById(id);
		if (visibleId === id) {
			div.style.display = "block";
		} else {
			div.style.display = "none";
		}
	}
}
/*end search selector*/
/*begin sets button as active*/
function calActive() {
	var element = document.getElementById("Cal");
	element.classList.add("active");
	var element = document.getElementById("Site");
	element.classList.remove("active");
}
function siteActive() {
	var element = document.getElementById("Cal");
	element.classList.remove("active");
	var element = document.getElementById("Site");
	element.classList.add("active");
}
/*end sets button as active*/
/*hide and show in page nav on narrow view ports*/
function showLeftNav() {
	var element = document.getElementById("leftNav");
	element.classList.toggle("showLeft");
	var element = document.getElementById("leftNavOpener");
	element.classList.toggle("close-btn");
}
function showRightNav() {
	var element = document.getElementById("rightNav");
	element.classList.toggle("showRight");
	var element = document.getElementById("rightNavOpener");
	element.classList.toggle("close-btn");
}

/*begin current search filter*/
$(document).ready(function () {
	// Get the current URL
	let url = window.location.href;

	// Extract the value of the filter ("&f=")
	let filterMatch = url.match(/[?&]f=([^&]*)/);
	if (filterMatch) {
		// Decode the filter value in case there are spaces or symbols
		let filterValue = decodeURIComponent(filterMatch[1]);

		// Set the decoded value as the text for ".current-filter"
		$('.current-filter').text("Filter: ");
		$('.current-filter').append("<strong class='filter-text mr-1'></strong>");

		$(".filter-text").text(filterValue);

		// Add a clear button
		$('.current-filter').append('<button class="clear-filter inactive btn btn-outline-dark btn-sm rounded-0" title="Clear Filter">Clear Filter</button>');
	}

	// Clear the filter on button click
	$(document).on('click', '.clear-filter', function () {
		// Remove "&f=" and everything that follows it from the URL
		let updatedUrl = url.replace(/[?&]f=[^&]*(&|$)/, function (match, trailingAmp) {
			return trailingAmp ? '?' : '';
		});

		// Remove any trailing "?" or "&"
		updatedUrl = updatedUrl.replace(/[?&]$/, '');

		// Reload the page with the updated URL
		window.location.href = updatedUrl;
	});
});
/*end current search filter*/

/*begin add interactions to the menu*/
const myTimeout = setTimeout(animateMenu, 900);
function animateMenu() {
	const addExpander = document.querySelectorAll(".has-children");
	const exPander = '<button class="accordion"> </button>';
	for (i = 0; i < addExpander.length; i++) {
		addExpander[i].insertAdjacentHTML('afterbegin', exPander);
	}

	var acc = document.getElementsByClassName("accordion");
	var i;

	for (i = 0; i < acc.length; i++) {
		acc[i].addEventListener("click", function () {
			this.classList.toggle("active");
			var menu = this.nextElementSibling.nextElementSibling;
			if (menu.style.display === "block") {
				menu.style.display = "none";
			} else {
				menu.style.display = "block";
			}
		});
	}
	const selectedLink = document.querySelector('ul._Skins_menu_left a.selected');
	if (!selectedLink) return;

	const parentLi = selectedLink.closest('li');
	const adjacentButton = parentLi?.querySelector(':scope > button.accordion');
	if (adjacentButton) adjacentButton.click();

	let current = parentLi?.parentElement;

	while (current) {
		if (current.tagName === 'LI') {
			const ancestorButton = current.querySelector(':scope > button.accordion');
			if (ancestorButton) ancestorButton.click();
		}
		// Stop when we reach the root menu element
		if (current.classList?.contains('mc-component')) break;
		current = current.parentElement;
	}
}

$(document).ready(function () {
	ClearSearch();
	$("div.search-bar-icon").prependTo("._Skins_Toolbar_Right ");
	$("div.search-wrapper").prependTo("._Skins_Toolbar_Right ");
});

/********* Clear Search **********/
function ClearSearch() {
	$(".search-filter-wrapper").before("<span class='clear-icon' title='Clear search'>×</span>");
	var search_button = setInterval(function () {
		if ($(".search-field").val().length > 0) {
			$(".clear-icon").show();
			$("ul#searchResultsDropdown").show();
		}
		clearInterval(search_button);
	}, 100);
	$(".search-field").keyup(function () {
		if ($(this).val().length == 0) {
			$(".clear-icon").hide();
			$("ul#searchResultsDropdown").hide();
		} else {
			$(".clear-icon").show();
			$("ul#searchResultsDropdown").show();
		}
	}).keyup();
	$(".clear-icon").click(function () {
		$(this).prev('input').val('').trigger('change').focus();
		$(".clear-icon").hide();
		$("ul#searchResultsDropdown").hide();
	});
};

// --------------------------------------------------
// Get references to the HTML elements
// --------------------------------------------------

// Main "Share" button
const toggle = document.getElementById("share-toggle");

// Container holding the share options
const options = document.getElementById("share-options");

// Individual share action buttons
const copyBtn = document.getElementById("copy-link");
const emailBtn = document.getElementById("email-link");

// --------------------------------------------------
// Helper functions
// --------------------------------------------------

// Returns the current page URL
const getPageUrl = () => window.location.href;

// Returns the current page title
const getPageTitle = () => document.title;


// --------------------------------------------------
// Toggle visibility of the share options
// --------------------------------------------------

// When the "Share" button is clicked...
toggle.addEventListener("click", () => {

	// Check whether the menu is currently hidden
	const isHidden = options.hasAttribute("hidden");

	if (isHidden) {

		// Remove the hidden attribute so the menu appears
		options.removeAttribute("hidden");

		// Update accessibility state
		toggle.setAttribute("aria-expanded", "true");

	} else {

		// Hide the menu again
		options.setAttribute("hidden", "hidden");

		// Update accessibility state
		toggle.setAttribute("aria-expanded", "false");
	}
});


// --------------------------------------------------
// Copy current page URL to clipboard
// --------------------------------------------------

copyBtn.addEventListener("click", async () => {

	// Get the current page URL
	const url = getPageUrl();

	try {

		// Use the Clipboard API to copy the URL
		await navigator.clipboard.writeText(url);

		// Temporarily change button text to confirm success
		copyBtn.textContent = "Copied";

	} catch {

		// Fallback for older browsers
		// Displays a prompt where the user can manually copy the URL
		prompt("Copy this link:", url);
	}
});


// --------------------------------------------------
// Open user's default email client
// --------------------------------------------------

emailBtn.addEventListener("click", () => {

	// Encode values so special characters work correctly in URLs
	const subject = encodeURIComponent(getPageTitle());

	const body = encodeURIComponent(
		`You might be interested in this topic: ${getPageUrl()}`
	);
	// Create a mailto link
	// This opens the user's default email application
	window.location.href = `mailto:?subject=${subject}&body=${body}`;
});