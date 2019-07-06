import {
  Controller
} from "stimulus"

export default class extends Controller {
  static targets = ["message"]

  close(event) {
    const notice = document.getElementById("notice")
    while (notice.firstChild) {
      notice.removeChild(notice.firstChild)
    }
  }
}
