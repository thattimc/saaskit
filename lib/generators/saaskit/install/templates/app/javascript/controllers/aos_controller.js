import {
  Controller
} from "stimulus"

import AOS from 'aos'

export default class extends Controller {
  connect() {
    AOS.init()
  }
}
