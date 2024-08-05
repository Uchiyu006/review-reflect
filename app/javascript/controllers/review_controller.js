import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "field", "output", "characterCount", "submitButton" ];

  static values = {
    characterCount: Number
  }

  connect() {
    this.count()    
  }

  count() {
    let length = this.fieldTarget.value.length
    let limit = this.characterCountTarget.value || this.characterCountValue;
    this.outputTarget.textContent = `現在 ${length} 文字`

    if(length > limit){
      this.submitButtonTarget.disabled = true;
      this.outputTarget.textContent += `(上限 ${limit} 文字を超えています)`
    } else {
      this.submitButtonTarget.disabled = false;
    }
  }
}
