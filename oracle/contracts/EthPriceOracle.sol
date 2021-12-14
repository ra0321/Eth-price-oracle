pragma solidity 0.5.0;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "./CallerContractInterface.sol";

contract EthPriceOracle is Ownable {

    uint private randNonce = 0;
    uint private modulus = 1000;
    mapping(uint256=>bool) pendingRequests;

    event GetLatestEthPriceEvent(address callerAddress, uint id);
    event SetLatestEthPriceEvent(uint256 ethPrice, address callerAddress);
    
    function getLatestEthPrice() public returns (uint256) {
        randNonce++;
        uint id = uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % modulus;
    }
}
