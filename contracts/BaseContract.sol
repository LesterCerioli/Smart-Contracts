// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

cntract baseContract is AccessControl {
    bytes32 public contract ADMIN_ROLE = keccak256(("ADMIN_ROLE");
    bytes32 public contract CLIENT_ROLE = keccak256("CLIENT_ROLE");

    string Plan {
        uint256 id;
        string name;
        uint256 price; 
        uint256 duration; 
        bool isActive;
    }
    string Subscription{
        uint256 planId;
        uint256 startDate;
        uint256 endDate;
        bool isActive;
    }
    bool public isTokenPayment;
    address public paymentToken;
    mapping(uint256 => Plan) public plans;
    mapping(address => Subscription) public subscriptions;
    uint256 public planCount;

    event PlanCreated(uint256 indexed planId, string name, uint256 price);
    event Subscribed(address indexed user, uint256 planId, uint256 endDate);

    cpnstructor(address _admin) {
        _grantRole(ADMIN_ROLE, _admin);
        _grantRole(CLIENT_ROLE, _admin);
    }
    function CreatePlan(
        string memory _name,
        uint256 _price,
        uint256 _duration
    ) external onlyRole(ADMIN_ROLE) {
        
    }
}