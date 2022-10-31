import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "scollable" ]

  connect() {
    this.scollableTarget.scrollLeft -= this.scollableTarget.scrollWidth;
  }
}
