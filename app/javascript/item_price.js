window.addEventListener('load', () => {
  const price = document.getElementById("item-price");
  price.addEventListener("input",() => {
    const inputValue = price.value;
    const addTaxPrice = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");
    //販売手数料と販売利益を計算し表示する処理
    addTaxPrice.textContent = Math.floor(inputValue * 0.1);
    profit.textContent = inputValue - addTaxPrice.textContent;
  });
});