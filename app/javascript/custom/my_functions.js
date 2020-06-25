
// window.dosmth = function() { 
//   alert('hello'); 
// }

function showForm() { 
  $('#secret_form').removeClass('hide').addClass('show');$('#hidden_form_button').addClass('hide');
  reveal_close_form_btn();

}

function reveal_close_form_btn() {
	$("#form_button_hidden").show();

}
document.addEventListener('turbolinks:load', () => {  
  const form_button = document.getElementById('form_button_hidden');
  $(form_button).hide();
  const clickButton = document.getElementById("hidden_form_button");  
  clickButton.addEventListener("click", showForm); 
});



// above from https://dev.to/morinoko/adding-custom-javascript-in-rails-6-1ke6

// morinoko profile image Felice Forby twitter logo github logo Author
// Oct 24 '19

// Well, I did some digging... Since these are webpack modules, I guess you have to do a little more work to make the function available if you're simply declaring it in pack/custom.js. First, you need to export function by adding an export at the end of the file:

// // javascript/packs/custom.js

// function dosmth() { 
//   alert('hello'); 
// }

// export default dosmth;

// Then, in the main application.js, you have to import it and make it available to the window. You can do that by adding this to the bottom of application.js

// // javascript/packs/application.js

// // require statements, etc....

// import dosmth from './custom'
// window.dosmth = dosmth

// Then it should work! I think there's a way to export and import all functions in a file too... I'm not very familiar with how webpack works yet, but I'll try to update this post with some more info soon.

// Instead of exporting/importing, another way is to add the onClick function with an event listener instead. First, give your button and id or something like that and remove the onclick:

// <%= button_tag 'Do smth', id: 'button-click', type: 'button' %> 

// Then in the custom.js file, add an event listener:

// // javascript/packs/custom.js

// function dosmth() { 
//   alert('hello'); 
// }

// document.addEventListener('turbolinks:load', () => {  
//   const clickButton = document.getElementById("button-click");  

//   clickButton.addEventListener("click", dosmth); 
// });

// You do need to make sure you wrap the event listener (and other JS) inside the document.addEventListener('turbolinks:load', () => {}. That's Rails' way of making sure the page and turbolinks is loaded before any of the javascript gets executed!

// I hope that helps!! I learned a bit trying to figure this out too!
// REPLY
// johnviviano profile image John Viviano github logo
// Nov 19 '19

// Thanks for this article. It was helpful. Changing the declaration of your JavaScript function may simplify things a bit:

// // in your html
// <a href="#" onclick="dosmth()">dosmth</a>

// // javascript/packs/custom.js
// window.dosmth = function() {
//   alert('hello');
// }

// I don't think you need the export default dosmth;
// export default dosmth;

// In your javascript/packs/application.js I don't think you need the corresponding declarations:

// import dosmth from './custom'
// window.dosmth = dosmth