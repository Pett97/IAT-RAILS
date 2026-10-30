import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["bore", "directionContainer", "direction"]

  connect() {
    this.toggleDirection()
  }

  toggleDirection() {
    const selectedBore = this.boreTarget.value
    const isRaiada = selectedBore.toLowerCase() === "raiada"

    this.directionContainerTarget.style.display =
      isRaiada ? "block" : "none"

    this.directionTarget.required = isRaiada

    if (!isRaiada) {
      this.directionTarget.value = ""
    }

    console.log("Bore:", selectedBore)
    console.log("Direção:", this.directionTarget.value)
  }
}