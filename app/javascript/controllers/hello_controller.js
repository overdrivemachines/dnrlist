import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // this.element.textContent = "Hello World!"
    // alert("connected");
    const guestModal = new bootstrap.Modal(this.element, {});
    guestModal.show();
  }
}
