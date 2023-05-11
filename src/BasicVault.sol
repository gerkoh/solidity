// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import ERC20Mock.sol;

contract BasicVault is ERC20Mock {
    
    // STATE VARS:

    // token

    // mapping to serve as balances registry
    mapping address => uint256 public balances;

    // events 
    event Transfer(address indexed sender, address indexed recipient, uint256 amount);
    event Withdrawal(address indexed sender, uint256 amount);
    
    // constructor function
    constructor() public{

    }

    // deposit function
    function transferFrom(address sender, address recipient, uint256 amount) {
        emit Transfer(sender, recipient, amount);
    }
    

    // withdraw function
    function withdrawal(uint256 amount) public {
        balances[msg.sender] -= amount;
        bool success = wmdToken.transfer(msg.sender, amount);
        require(success, "Insufficient balance");
        emit Withdrawal(msg.sender, amount);       
    }
    
}