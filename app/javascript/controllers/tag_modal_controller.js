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
    const tagName = event.target.nextElementSibling?.textContent?.trim() || `Tag ${tagId}`

    const existingInput = document.getElementById(`tag-hidden-${tagId}`)

    if (event.target.checked) {
      if (!existingInput) {
        const input = document.createElement('input')
        input.type = 'hidden'
        input.name = 'content[tag_ids][]'
        input.value = tagId
        input.id = `tag-hidden-${tagId}`
        input.dataset.tagId = tagId
        input.dataset.tagName = tagName
        this.hiddenTagTarget.appendChild(input)
      }
    } else {
      if (existingInput) {
        existingInput.remove()
      }
    }
  }

  updateTagDisplay() {
    const hiddenInputs = this.hiddenTagTarget.querySelectorAll("input[name='content[tag_ids][]']")
    this.selectedTagsTarget.innerHTML = ""

    hiddenInputs.forEach(input => {
      const span = document.createElement("span")
      span.textContent = input.dataset.tagName || `Tag ${input.value}`
      span.className = "px-2 py-1 border-b border-gray-800 text-sm text-gray-800 rounded-none"
      this.selectedTagsTarget.appendChild(span)
    })
  }
}
