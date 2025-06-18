import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "icon"]

  toggle(event) {
    const content = this.contentTarget
    const icon = this.iconTarget

    if (content.style.maxHeight) {
      content.style.maxHeight = null
      icon.classList.remove("rotate-180")
    } else {
      content.style.maxHeight = content.scrollHeight + "px"
      icon.classList.add("rotate-180")
    }
  }
}
