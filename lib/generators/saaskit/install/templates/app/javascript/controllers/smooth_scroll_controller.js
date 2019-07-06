import {
  Controller
} from "stimulus"

import SmoothScroll from 'smooth-scroll'

export default class extends Controller {
  connect() {
    var scroll = new SmoothScroll('a[href*="#"]')
  }
}
