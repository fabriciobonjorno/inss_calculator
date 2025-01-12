import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="inss"
export default class extends Controller {
  static targets = ["incomeField", "inssValueField"];

  connect() {
    this.incomeFieldTarget.addEventListener("input", this.handleInput.bind(this));
  }

  handleInput() {
    this.formatIncome();
    this.calculateINSS();
  }

  formatIncome() {
    let value = this.incomeFieldTarget.value.replace(/\D/g, "");
    if (value) {
      value = (parseInt(value) / 100).toFixed(2);
      this.incomeFieldTarget.value = `${value.replace(".", ",")}`;
      this.incomeFieldTarget.dataset.rawValue = value;
    } else {
      this.incomeFieldTarget.value = "";
      this.incomeFieldTarget.dataset.rawValue = "0";
    }
  }

  async calculateINSS() {
    const income = parseFloat(this.incomeFieldTarget.dataset.rawValue || "0");

    if (income > 0) {
      try {
        const response = await fetch(`/calculate_inss?income=${income}`, {
          headers: { Accept: "text/vnd.turbo-stream.html" }
        });

        if (response.ok) {
          const html = await response.text();

          console.log("Resposta do servidor:", html);

          const inssValueContainer = document.getElementById("inss_value");
          inssValueContainer.innerHTML = html;

          const regex = /R\$ (\d+\.\d{2})/;
          const match = html.match(regex);

          if (match) {
            const inssString = match[1];
            let inssNumeric = parseFloat(inssString);

            const formattedInss = inssNumeric.toFixed(2);
            this.inssValueFieldTarget.value = formattedInss;
          } else {
            console.error("Formato de valor de INSS inesperado", html);
          }

        } else {
          console.error("Erro ao calcular INSS:", response);
        }
      } catch (error) {
        console.error("Erro ao realizar a requisição:", error);
      }
    } else {
      const inssValueContainer = document.getElementById("inss_value");
      inssValueContainer.innerHTML = "Valor do INSS: <strong>R$ 0,00</strong>";
      this.inssValueFieldTarget.value = "0,00";
    }
  }
}