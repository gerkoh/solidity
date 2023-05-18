// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import {ERC20} from "../lib/yield-utils-v2/src/token/ERC20.sol";

contract ETHWrapper is ERC20 {
    ERC20 public token;

    mapping (address => uint256) public balances;

    event Wrapped(address indexed recipient, uint256 amount);
    event Unwrapped(address indexed sender, uint256 amount);

    constructor(ERC20 token_, string memory name_, string memory symbol_, uint8 decimals_) ERC20(name_, symbol_, decimals_) {
        token = token_;
    }
    
    function mint(address dst, uint wad) internal {
        _mint(dst, wad);
    }

    function burn(address src, uint wad) internal {
        _burn(src, wad);
    }

    // Wrapping ERC20 to ERC20
    function wrap(uint amount) public {
        // uint256 amount = msg.value; // eth
        mint(msg.sender, amount);
        balances[msg.sender] += amount; // record keeping
        bool success = token.transferFrom(msg.sender, address(this), amount); // actual transfer
        require(success, "Unsuccessful wrapping");
        emit Wrapped(msg.sender, amount);
    }

    function unwrapped(uint amount) public {
        // uint256 amount = msg.value; // eth
        require(this.balanceOf(msg.sender) >= amount, "Insufficient balance");
        // require(balances[msg.sender] >= amount, "Insufficient balance")
        burn(msg.sender,amount);
        balances[msg.sender] -= amount; // record keeping
        bool success = token.transferFrom(address(this), msg.sender, amount); // actual transfer
        require(success, "Unsuccessful unwrapping");
        emit Unwrapped(msg.sender, amount);
    }
}