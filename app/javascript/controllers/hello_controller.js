import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // this.element.textContent = "Hello World!"
    // alert("connected");
    const editGuestModal = new bootstrap.Modal(this.element, {});
    editGuestModal.show();
  }
}
