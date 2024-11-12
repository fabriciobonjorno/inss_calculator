import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="multi-step-form"
export default class extends Controller {
  static targets = ["step", "next", "previous", "submit"];

  initialize() {
    this.currentStep = 0;
    this.updateStep();
  }

  next() {
    if (this.currentStep < this.stepTargets.length - 1) {
      this.currentStep++;
      this.updateStep();
    }
  }

  previous() {
    if (this.currentStep > 0) {
      this.currentStep--;
      this.updateStep();
    }
  }

  updateStep() {
    this.stepTargets.forEach((step, index) => {
      step.classList.toggle("d-none", index !== this.currentStep);
    });

    this.previousTarget.classList.toggle("d-none", this.currentStep === 0);
    this.nextTarget.classList.toggle("d-none", this.currentStep === this.stepTargets.length - 1);
    this.submitTarget.classList.toggle("d-none", this.currentStep !== this.stepTargets.length - 1);
  }
}
