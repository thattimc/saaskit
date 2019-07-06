import {
  Controller
} from "stimulus"

import Typed from 'typed.js'

export default class extends Controller {
  connect() {
    var options = {
      stringsElement: '#typed-strings',
      typeSpeed: 40,
      loop: true
    }

    var typed = new Typed("#typed", options);
  }
}
