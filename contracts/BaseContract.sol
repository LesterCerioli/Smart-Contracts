// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract SaaSCrypto is AccessControl {
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant CLIENT_ROLE = keccak256("CLIENT_ROLE");

    struct Plan {
        uint256 id;
        string name;
        uint256 price; 
        uint256 duration; 
        bool isActive;
    }

    struct Subscription {
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

    constructor(address _admin) {
        _grantRole(ADMIN_ROLE, _admin);
        _grantRole(CLIENT_ROLE, _admin); 
    }

    
    function createPlan(
        string memory _name,
        uint256 _price,
        uint256 _duration
    ) external onlyRole(ADMIN_ROLE) {
        planCount++;
        plans[planCount] = Plan(planCount, _name, _price, _duration, true);
        emit PlanCreated(planCount, _name, _price);
    }

    function toggleTokenPayment(bool _isTokenPayment, address _token) external onlyRole(ADMIN_ROLE) {
        isTokenPayment = _isTokenPayment;
        paymentToken = _token;
    }

   
    function subscribe(uint256 _planId) external payable {
        require(plans[_planId].isActive, "Inactived Plan");
        
        if (isTokenPayment) {
            IERC20 token = IERC20(paymentToken);
            require(
                token.transferFrom(msg.sender, address(this), plans[_planId].price),
                "Payment Failed"
            );
        } else {
            require(msg.value >= plans[_planId].price, "Insuficient ETH ");
        }

        subscriptions[msg.sender] = Subscription(
            _planId,
            block.timestamp,
            block.timestamp + plans[_planId].duration,
            true
        );

        _grantRole(CLIENT_ROLE, msg.sender);
        emit Subscribed(msg.sender, _planId, block.timestamp + plans[_planId].duration);
    }

    
    function checkAccess(address _user) public view returns (bool) {
        return subscriptions[_user].isActive && subscriptions[_user].endDate >= block.timestamp;
    }
}