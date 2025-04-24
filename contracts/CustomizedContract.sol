// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CustomizedContract {
    string private message;
    
    constructor(string memory _initialMessage) {
        message = _initialMessage;
    }
    
    function getMessage() public view returns (string memory) {
        return message;
    }
}