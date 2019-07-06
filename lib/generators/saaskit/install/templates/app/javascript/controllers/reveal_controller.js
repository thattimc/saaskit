import {
  Controller
} from "stimulus"

export default class extends Controller {
  static targets = ["content"]

  show(event) {
    event.preventDefault()
    event.stopImmediatePropagation()

    if (this.open) {
      event.currentTarget.textContent = "Show more 👇"

      this.contentTarget.scrollIntoView()

      this.contentTarget.style.height = null

      this.contentTarget.classList.remove("h-auto", "after:h-0")
      this.contentTarget.classList.add("h-120", "after:h-120")

      this.open = false
    } else {
      event.currentTarget.textContent = "Show less ☝️"

      this.contentTarget.style.height = this.contentTarget.scrollHeight + "px"

      this.contentTarget.classList.remove("h-120", "after:h-120")
      this.contentTarget.classList.add("h-auto", "after:h-0")

      this.open = true
    }
  }

  get open() {
    const openBool = (this.data.get("open") == "true")
    return openBool
  }

  set open(value) {
    this.data.set("open", value)
  }
}
