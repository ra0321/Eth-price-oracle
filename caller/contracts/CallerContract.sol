pragma solidity 0.5.0;

import "./EthPriceOracleInterface.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract CallerContract is Ownable {

    EthPriceOracleInterface private oracleInstance;
    address private oracleAddress;

    event newOracleAddressEvent(address oracleAddress);

    function setOracleInstanceAddress(address _oracleInstanceAddress) public onlyOwner {
        oracleAddress = _oracleInstanceAddress;
        oracleInstance = EthPriceOracleInterface(oracleAddress);
        emit newOracleAddressEvent(oracleAddress);
    }
}