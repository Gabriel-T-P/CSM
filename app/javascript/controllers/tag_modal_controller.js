import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "hiddenTag", "selectedTags"]

  open() {
    this.modalTarget.classList.remove("hidden", "invisible")
    this.modalTarget.classList.add("flex")
  }

  close() {
    this.modalTarget.classList.remove("flex")
    this.modalTarget.classList.add("hidden", "invisible")

    this.updateTagDisplay()
  }

  toggle(event) {
    const tagId = event.target.dataset.tagId
    const hiddenInput = this.hiddenTagTargets.find(el => el.dataset.tagId == tagId)
    if (hiddenInput) {
      hiddenInput.disabled = !event.target.checked
    }
  }

  updateTagDisplay() {
    const selected = this.hiddenTagTargets.filter(el => !el.disabled)
    this.selectedTagsTarget.innerHTML = ""

    selected.forEach(input => {
      const span = document.createElement("span")
      span.textContent = input.value
      span.className = "bg-gray-200 text-gray-700 text-sm px-2 py-1 rounded"
      this.selectedTagsTarget.appendChild(span)
    })
  }
}
