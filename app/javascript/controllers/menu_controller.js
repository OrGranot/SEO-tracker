
import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
    const activeElem = document.querySelector('.menu-item.active')
    activeElem?.closest('.menu-item.dropdown')?.classList.add('open')

  }
}
