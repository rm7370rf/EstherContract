pragma solidity ^0.4.0;

import "./StringUtils.sol";

contract Username {
    using StringUtils for string;

    mapping(address => string) userNames;
    mapping(string => address) addresses;

    function setUserName(string userName) public {
        require(!userName.isEmpty() && (addresses[userName.toLower()] == 0) && (userNames[msg.sender].isEmpty()));
        userNames[msg.sender] = userName;
        addresses[userName] = msg.sender;
    }

    function getUserName(address userAddress) public view returns (string) {
        return userNames[userAddress];
    }
}
