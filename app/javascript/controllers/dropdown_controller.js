import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    this.boundCloseAll = this.closeIfClickedOutside.bind(this)
    document.addEventListener("click", this.boundCloseAll)

    window.addEventListener("dropdown:closeAll", (event) => {
      if (event.detail !== this) {
        this.close()
      }
    })
  }

  disconnect() {
    document.removeEventListener("click", this.boundCloseAll)
    window.removeEventListener("dropdown:closeAll", this.boundCloseAll)
  }

  toggle(event) {
    event.stopPropagation()

    const isOpen = this.menuTarget.classList.contains("opacity-100")

    window.dispatchEvent(new CustomEvent("dropdown:closeAll", { detail: this }))

    if (!isOpen) {
      this.open()
    } else {
      this.close()
    }
  }

  open() {
    this.menuTarget.classList.add("opacity-100", "pointer-events-auto")
    this.menuTarget.classList.remove("opacity-0", "pointer-events-none")
  }

  close() {
    this.menuTarget.classList.remove("opacity-100", "pointer-events-auto")
    this.menuTarget.classList.add("opacity-0", "pointer-events-none")
  }

  closeIfClickedOutside(event) {
    if (!this.element.contains(event.target)) {
      this.close()
    }
  }
}
