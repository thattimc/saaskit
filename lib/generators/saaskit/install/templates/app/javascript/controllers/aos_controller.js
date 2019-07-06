import {
  Controller
} from "stimulus"

import AOS from 'aos'
import 'aos/dist/aos.css'

export default class extends Controller {
  connect() {
    AOS.init()
  }
}
