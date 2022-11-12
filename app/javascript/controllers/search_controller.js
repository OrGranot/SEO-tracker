
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form", "input"]
  connect() {
    const end = this.inputTarget.value.length;
      this.inputTarget.setSelectionRange(end, end)
      this.inputTarget.focus()
  }

  submit() {
    const submit = setTimeout(() => {
      this.formTarget.requestSubmit()
    }, 500)
    document.addEventListener('keydown', () => {
      clearTimeout(submit)
    }, {once: true})

  }
}
