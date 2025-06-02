import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container", "menu", "icon"]

  connect() {
    this.open = false
  }

  toggle(event) {
    this.open = !this.open
    this.updateDropdown()
  }

  close() {
    this.open = false
    this.updateDropdown()
  }

  closeIfOutside(event) {
    if (!this.containerTarget.contains(event.target)) {
      this.close()
    }
  }

  updateDropdown() {
    if (this.open) {
      this.menuTarget.classList.remove("opacity-0", "pointer-events-none")
      this.menuTarget.classList.add("opacity-100", "pointer-events-auto")
      this.iconTarget.classList.add("rotate-180")
    } else {
      this.menuTarget.classList.remove("opacity-100", "pointer-events-auto")
      this.menuTarget.classList.add("opacity-0", "pointer-events-none")
      this.iconTarget.classList.remove("rotate-180")
    }
  }
}
