class BitcoinConversion
  def self.btc_to_satoshi(btc)
    btc = btc.to_f
    raise if btc < 0.00000001
    (btc / 0.00000001).to_i
  end

  def self.satoshi_to_btc(satoshi)
    btc = satoshi.to_i * 0.00000001
    btc_str = "%.8f" % btc
    satoshi.to_s.length >= 8 ? btc : btc_str
  end
end
