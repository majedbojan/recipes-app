import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["container", "template"]

  addItem(e) {
    let content = this.templateTarget.innerHTML.replace(/TEMPLATE_RECORD/g, Math.floor(Math.random() * 20))
    this.containerTarget.insertAdjacentHTML('beforeend', content)
  }

  removeItem(e) {
    e.preventDefault()
    let item = e.target.closest(".nested-fields")
    item.querySelector("input[name*='_destroy']").value = 1
    item.style.display = 'none'
  }
}
