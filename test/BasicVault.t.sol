// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "../src/BasicVault.sol";

// Testing guidelines
// All state variable changes in the contracts that you code.
// All state variable changes in other contracts caused by calls from contracts that you code.
// All require or revert in the contracts that you code.
// All events being emitted.
// All return values in contracts that you code.

abstract contract StateZero is Test {
    BasicVault public basicVault;
    address public user;

    function setUp() public virtual {
        // deploy contract
        basicVault = new BasicVault(IERC20(address(1)));

        // initialise variables
        user = address(1);
        vm.label(user, "user");
    }
}

// deployment
// deposit
// withdraw