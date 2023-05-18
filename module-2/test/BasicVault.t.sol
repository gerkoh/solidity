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

// deployment
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

contract StateZeroTest is StateZero {
    

    // function testDeposit(uint256 amount) public {
    //     console2.log("User deposits tokens");
    //     vm.prank(user);
    //     basicVault.deposit(amount);
    //     bool success = (amount == basicVault.balances(user));
    //     assertTrue(success);
    // }

    // function testWithdrawal(uint256 amount) public {
    //     console2.log("User withdraws tokens");
    //     vm.prank(user);
    //     basicVault.withdrawal(amount);
    //     bool success = (amount == basicVault.balances(user));
    //     assertTrue(success);
    // }

    // function testCannotWithdrawMoreThanBalance(uint256 amount) public {
    //     console2.log("User cannot withdraw more than balance");
    //     vm.prank(user);
    //     vm.expectRevert(bytes("Insufficient balance"));
    //     basicVault.withdrawal(amount);
    // }

    // function testCannotDepositMoreThanBalance(uint256 amount) public {
    //     console2.log("User cannot deposit more than balance");
    //     vm.prank(user);
    //     vm.expectRevert(bytes("Insufficient balance"));
    //     basicVault.deposit(amount);
    // }

    // function testCannotDepositMoreThanAllowance(uint256 amount) public {
    //     console2.log("User cannot deposit more than allowance");
    //     vm.prank(user);
    //     vm.expectRevert(bytes("Insufficient balance"));
    //     basicVault.deposit(amount);
    // }

    // function testCannotWithdrawMoreThanAllowance(uint256 amount) public {
    //     console2.log("User cannot withdraw more than allowance");
    //     vm.prank(user);
    //     vm.expectRevert(bytes("Insufficient balance"));
    //     basicVault.withdrawal(amount);
    // }

    // function testCannotWithdrawMoreThanBalanceAndAllowance(uint256 amount) public {
    //     console2.log("User cannot withdraw more than balance and allowance");
    //     vm.prank(user);
    //     vm.expectRevert(bytes("Insufficient balance"));
    //     basicVault.withdrawal(amount);
    // }

    // function testCannotDepositMoreThanBalanceAndAllowance(uint256 amount) public {
    //     console2.log("User cannot deposit more than balance and allowance");
    //     vm.prank(user);
    //     vm.expectRevert(bytes("Insufficient balance"));
    //     basicVault.deposit(amount);
    // }
}

// deposit
abstract contract StateDeposit is Test {
    address user;
    string name;

    function setUp() public override {
        // deploys the contract in the earlier StateZero
        super.setUp();
        user = address(1);

        // state transition, rewrites the variables that were initialised in StateZero
        user = address(0xE6A2e85916802210147e366D4431f5ca4dD51a78);
    }
}

contract StateDepositTest is StateDeposit {
    function 
}

// withdraw
abstract contract StateWithdraw is Test {
    address user;
    string name;
}

contract StateWithdrawTest is StateWithdraw {
    function testUserCannotWithdrawMoreThanBalance() public {
        console2.log("User cannot withdraw more than balance");
        vm.expectRevert(bytes("Insufficient balance"));
        basicVault.withdrawal(amount);
    }
}