
import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
    const activeElem = document.querySelector('.menu-item.active')
    const dropDownElem = activeElem.closest('.menu-item.dropdown')
    if (!dropDownElem) return

    dropDownElem.classList.add('open')
  }
}
