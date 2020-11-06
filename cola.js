function paiduayTechCola(n) {
  if (n < 1 || isNaN(n)) {
    return 0;
  }
  const a = n / 3;
  return Math.floor(a + n);
}

console.log(paiduayTechCola(1));