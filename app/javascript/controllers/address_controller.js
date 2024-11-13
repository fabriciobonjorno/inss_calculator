import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"
import debounce from 'lodash.debounce'

// Connects to data-controller="address"
export default class extends Controller {
  static targets = ["zipCode", "state", "city", "street", "other", "neighborhood"];

  initialize() {
    this.debouncedFetch = debounce(this.fetch.bind(this), 300);
    this.zipCodeTarget.addEventListener('input', this.formatZipCode.bind(this));
    this.zipCodeTarget.addEventListener('input', this.debouncedFetch);
  }

  fetch() {
    let zipCode = this.zipCodeTarget.value.replace(/\D/g, '');
    if (zipCode.length !== 8) return;

    get(`/get_address/${zipCode}`, { responseKind: "json" })
      .then(response => response.json)
      .then(data => this.#updateFields(data))
      .catch(error => {
        console.error("Erro ao buscar endereço:", error);
      });
  }

  #updateFields(data) {
    const userAddress = new UserAddress(data);
    this.streetTarget.value = userAddress.street;
    this.neighborhoodTarget.value = userAddress.neighborhood;
    this.cityTarget.value = userAddress.city;
    this.stateTarget.value = userAddress.state;
    this.otherTarget.value = userAddress.other;
  }

  formatZipCode(event) {
    let zipCode = this.zipCodeTarget.value.replace(/\D/g, '');
    if (zipCode.length > 5) {
      zipCode = zipCode.replace(/(\d{5})(\d{3})/, '$1-$2');
    } else {
      zipCode = zipCode.replace(/(\d{2})(\d{3})/, '$1.$2');
    }
    this.zipCodeTarget.value = zipCode;
  }
}

class UserAddress {
  constructor(data) {
    this.zipCode = data.cep || "";
    this.street = data.logradouro || "";
    this.neighborhood = data.bairro || "";  // Corrigido para 'neighborhood'
    this.city = data.localidade || "";
    this.state = data.uf || "";
    this.other = [data.complemento, data.bairro, data.logradouro].filter(Boolean).join(", ");
  }
}