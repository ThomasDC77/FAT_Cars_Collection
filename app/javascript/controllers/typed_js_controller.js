import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js"

// Connects to data-controller="typed-js"
export default class extends Controller {
  connect() {
    new Typed(this.element, {
      strings: ["Bienvenue chez FAT Cars Collection !", "Les plus beaux véhicules !"],
      typeSpeed: 70,
      loop: true
    })
  }
}
