
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "input" ]

  connect() {
    this.inputTarget.focus();
  }
}
