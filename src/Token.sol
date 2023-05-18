// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import {ERC20} from "../lib/yield-utils-v2/src/token/ERC20.sol";

contract Token is ERC20 {
    // token
    ERC20 public token;
    

    // mapping to serve as balances registry
    mapping (address => uint256) public balances;
    
    // constructor function
    constructor(ERC20 token_, string memory name_, string memory symbol_, uint8 decimals_) ERC20(name_, symbol_, decimals_) {
        token = token_;
    }   
}