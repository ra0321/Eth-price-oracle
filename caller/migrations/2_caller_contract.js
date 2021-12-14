const CallerContract = artifacts.require('CallerContract')

module.exports = function (deployer) {
  deployer.deploy(CallerContract)
}