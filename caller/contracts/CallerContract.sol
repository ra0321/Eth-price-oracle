pragma solidity 0.5.0;

contract CallerContract {

    address private oracleAddress;

    function setOracleInstanceAddress(address _oracleInstanceAddress) public {
        oracleAddress = _oracleInstanceAddress;
    }
}