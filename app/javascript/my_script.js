
let options = {
  valueNames: ["name", "dob"]
};

// Looks for element with id "guests"
let guestList = new List("guests", options);

// Bootstrap Popover
const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]');
const popoverList = [...popoverTriggerList].map(popoverTriggerEl => new bootstrap.Popover(popoverTriggerEl));
