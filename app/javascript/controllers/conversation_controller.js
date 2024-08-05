import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="conversation"
export default class extends Controller {
  static targets = [ "field", "submitButton" ];

  connect() {
    this.toggleSubmitButton()
  }

  toggleSubmitButton(){
    let isEmpty = this.fieldTargets.every(field => field.value.trim() === "")
    this.submitButtonTarget.disabled = isEmpty;
  }

  check() {
    this.toggleSubmitButton();
  }
}
