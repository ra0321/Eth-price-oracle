const EthPriceOracle = artifacts.require('EthPriceOracle')

module.exports = function (deployer) {
  deployer.deploy(EthPriceOracle, '0xb090d88a3e55906de49d76b66bf4fe70b9d6d708')
}