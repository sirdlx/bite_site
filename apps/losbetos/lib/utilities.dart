String toPricingText(int price) {
  return '\$${(price / 100).toStringAsFixed(2)}';
}
