pragma solidity 0.5.0;

import "openzeppelin-solidity/contracts/access/Roles.sol";
import "./CallerContractInterface.sol";

contract EthPriceOracle {

    using Roles for Roles.Role;

    Roles.Role private owners;
    Roles.Role private oracles;
    uint private randNonce = 0;
    uint private modulus = 1000;
    mapping(uint256 => bool) pendingRequests;

    event GetLatestEthPriceEvent(address callerAddress, uint id);
    event SetLatestEthPriceEvent(uint256 ethPrice, address callerAddress);
    event AddOracleEvent(address oracleAddress);

    constructor (address _owner) public {
        owners.add(_owner);
    }

    function addOracle(address _oracle) public {
        require(owners.has(msg.sender), "Not an owner!");
    }
    
    function getLatestEthPrice() public returns (uint256) {
        randNonce++;
        uint id = uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % modulus;

        pendingRequests[id] = true;

        emit GetLatestEthPriceEvent(msg.sender, id);

        return id;
    }

    function setLatestEthPrice(uint256 _ethPrice, address _callerAddress, uint256 _id) public onlyOwner {
        require(pendingRequests[_id], "This request is not in my pending list.");
        delete pendingRequests[_id];

        CallerContractInterface callerContractInstance;
        callerContractInstance = CallerContractInterface(_callerAddress);
        callerContractInstance.callback(_ethPrice, _id);

        emit SetLatestEthPriceEvent(_ethPrice, _callerAddress);
    }
}
