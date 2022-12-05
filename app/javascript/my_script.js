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
  //////////////////////////////////////////////////
  // Bootstrap Popover
  //////////////////////////////////////////////////
  const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]');
  const popoverList = [...popoverTriggerList].map((popoverTriggerEl) => new bootstrap.Popover(popoverTriggerEl));

  //////////////////////////////////////////////////
  // Search Guest Names
  //////////////////////////////////////////////////

  // returns: John Smith 05/12/81
  function getUnformattedNameDOB(guestEl) {
    let name =
      guestEl.querySelector(".name").childNodes[0].textContent.trim() +
      " " +
      guestEl.querySelector(".last-name").textContent.trim() +
      " " +
      guestEl.querySelector(".dob").textContent.trim();
    return name.trim();
  }

  function getLastnameInitial(guestEl) {
    return guestEl.querySelector(".last-name").textContent.trim().slice(0, 1);
  }

  const searchEl = document.getElementById("name");
  function searchGuest(e, indexLetter = "") {
    const li = document.querySelectorAll(".guest");
    const searchName = searchEl.value.toUpperCase();
    let name = "";
    let lastnameInitial = "";

    if (indexLetter != "") {
      console.log("Searching for Guests starting with letter", indexLetter);
      // Loop through all list items, and hide those who don't match the starting letter
      for (let i = 0; i < li.length; i++) {
        lastnameInitial = getLastnameInitial(li[i]).toUpperCase();

        if (lastnameInitial == indexLetter) {
          li[i].style.display = "";
        } else {
          li[i].style.display = "none";
        }
      }
    } else if (searchName.length < 3) {
      for (let i = 0; i < li.length; i++) {
        li[i].style.display = "none";
      }
    } else {
      // Loop through all list items, and hide those who don't match the search query
      for (let i = 0; i < li.length; i++) {
        name = getUnformattedNameDOB(li[i]);
        if (name.toUpperCase().indexOf(searchName) > -1) {
          li[i].style.display = "";
        } else {
          li[i].style.display = "none";
        }
      }
    }
  }

  // Add event listener only when searchEl is present
  if (searchEl) {
    searchEl.addEventListener("keyup", searchGuest);
  }

  //////////////////////////////////////////////////
  // Index Link
  //////////////////////////////////////////////////
  function callSearch(e) {
    e.preventDefault();
    const letter = e.target.id.slice(-1).toUpperCase();
    searchGuest(e, letter);
  }

  const indexLinks = $(".index-link");
  if (indexLinks) {
    for (let i = 0; i < indexLinks.length; i++) {
      const indexLink = indexLinks[i];
      indexLink.addEventListener("click", callSearch);
    }
  }

  //////////////////////////////////////////////////
  // Return to Top Button
  //////////////////////////////////////////////////
  const returnToTopBtn = $("#return-to-top");

  // When the user scrolls down 520px from the top of the document, show the button
  window.onscroll = function () {
    scrollFunction();
  };

  function scrollFunction() {
    if (document.body.scrollTop > 520 || document.documentElement.scrollTop > 520) {
      returnToTopBtn.style.display = "block";
    } else {
      returnToTopBtn.style.display = "none";
    }
  }

  // When the user clicks on the button, scroll to the top of the document
  function returnToTop() {
    document.body.scrollTop = 0; // For Safari
    document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera
  }

  window.returnToTop = returnToTop;
});

// This function runs on every turbo frame
document.addEventListener("turbo:frame-load", function (e) {
  console.log("frame load", Math.random());
});
