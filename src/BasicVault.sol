// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import ERC20Mock.sol;

contract BasicVault is ERC20Mock {
    
    // STATE VARS:

    // token

    // mapping to serve as balances registry
    mapping address => uint256 public balances;

    // events 
    event Deposit(address indexed recipient, uint256 amount);
    event Withdrawal(address indexed sender, uint256 amount);
    
    // constructor function
    constructor(string memory name, string memory symbol) ERC20Mock(name, symbol) public {
    }

    // deposit function
    function deposit(address recipient, uint256 amount) public {
        balances[msg.sender] += amount;
        bool success = wmdToken.transfer(msg.sender, amount);
        require(success, "Insufficient balance");
        emit Deposit(msg.sender, amount);
    }
    

    // withdraw function
    function withdrawal(uint256 amount) public {
        balances[msg.sender] -= amount;
        bool success = wmdToken.transfer(msg.sender, amount);
        require(success, "Insufficient balance");
        emit Withdrawal(msg.sender, amount);       
    }
    
}