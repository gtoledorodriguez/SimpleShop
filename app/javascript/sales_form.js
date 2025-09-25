function initSalesForm() {
  // NOTE: Awesome job, love to see javascript being implemented
  console.log("Sales form JS initialized");

  const itemSelect = document.getElementById("sale_item_id");
  const priceField = document.getElementById("item_price");
  const quantityField = document.getElementById("quantity_sold");
  const totalField = document.getElementById("total_price");
  const calcButton = document.getElementById("calculate_total");

  if (!itemSelect) return;

  const itemPrices = JSON.parse(document.getElementById("item_prices_json").textContent);
  console.log("Item prices loaded:", itemPrices);

  function updatePrice() {
    const itemId = parseInt(itemSelect.value);
    const quantity = parseFloat(quantityField.value) || 0;
    console.log("Selected item:", itemId, "Quantity:", quantity);

    if (itemId && itemPrices[itemId] !== undefined) {
      const price = itemPrices[itemId];
      priceField.value = price.toFixed(2);
      totalField.value = quantity > 0 ? (price * quantity).toFixed(2) : '';
      console.log("Total price updated:", totalField.value);
    } else {
      priceField.value = '';
      totalField.value = '';
    }
  }

  itemSelect.addEventListener("change", updatePrice);
  quantityField.addEventListener("input", updatePrice);
  // calcButton.addEventListener("click", updatePrice);
}

// Execute on both initial load and Turbo page visits
document.addEventListener("DOMContentLoaded", initSalesForm);
document.addEventListener("turbo:load", initSalesForm);
