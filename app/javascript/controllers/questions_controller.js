import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="questions"
export default class extends Controller {
  static targets = ["question2", "question3", "question4", "question5"]

  connect() {
    console.log("Questions controller connected")
  }

  checkQuestion2() {
    if (this.question2Target.value == "No") {
      this.question3Target.classList.remove("d-none")
    } else {
      this.question3Target.classList.add("d-none")
    }
  }

  checkQuestion4() {
    if (this.question4Target.value == "No") {
      this.question5Target.classList.remove("d-none")
    } else {
      this.question5Target.classList.add("d-none")
    }
  }
}
