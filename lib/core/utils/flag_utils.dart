String currencyCodeToEmoji(String code) {
  // Most currency codes: first 2 letters = country code (e.g., US, NG, SG)
  if (code.length < 2) return "🏳️";

  final countryCode = code.substring(0, 2).toUpperCase();

  // Convert letters to regional indicator symbols 🇦 - 🇿
  int base = 0x1F1E6; // regional indicator 'A'
  return countryCode
      .codeUnits
      .map((c) => String.fromCharCode(base + (c - 65)))
      .join();
}
