// Helper function to select elements
// returns element with matching ID
// or
// returns array of elements with matching class
function $(el) {
  if (el.charAt(0) === "#") {
    // if el begins with # then find element with id
    return document.getElementById(el.substring(1));
  } else {
    return document.querySelectorAll(el);
  }
}
// make the function available
window.$ = $;

// This function runs on every page "load"
document.addEventListener("turbo:load", () => {
  // list.js needs to be initialized
  let options = {
    valueNames: ["name", "dob"]
  };

  // Looks for element with id "guests"
  let guestList = new List("guests", options);

  // Bootstrap Popover
  const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]');
  const popoverList = [...popoverTriggerList].map(popoverTriggerEl => new bootstrap.Popover(popoverTriggerEl));

});

// This function runs on every turbo frame
document.addEventListener("turbo:frame-load", function (e) {
  console.log("frame load", Math.random());
});
