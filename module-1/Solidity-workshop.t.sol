
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "../src/Solidity-workshop.sol";

abstract contract StateZero is Test {
    SimpleNameRegister public simpleNameRegister;
    address public user;

    function setUp() public virtual {
        // deploy contract
        simpleNameRegister = new SimpleNameRegister();

        // initialise variables
        user = address(1);
        vm.label(user, "user");
    }
}

// state 1 upon deployment
contract StateZeroTest is StateZero {
    function testCannotRelease(string memory testString) public {  
        console2.log("Cannot release a name that you do not hold");
        vm.prank(user);
        vm.expectRevert(bytes("Not your name!"));
        simpleNameRegister.release(testString);
    }

    function testRegister(string memory testString) public {
        console2.log("User registers a name");
        vm.prank(user);
        simpleNameRegister.register(testString);
        bool success = (user == simpleNameRegister.holder(testString));
        assertTrue(success);
    }
}

abstract contract StateRegistered is StateZero {
    address adversary;
    string name;

    function setUp() public override {
        // deploys the contract in the earlier StateZero
        super.setUp();
        adversary = 0xE6A2e85916802210147e366D4431f5ca4dD51a78;
        vm.label(adversary, "adversary");
        
        // state transition, rewrites the variables that were initialised in StateZero
        name = 'whale';
        vm.prank(user);
        simpleNameRegister.register(name);
    }
}

// state 2 when there is a state change
contract StateRegisteredTest is StateRegistered {

    // 1st iteration uses the adversary address in abstract contract
    function testAdversaryCannotRegisterName() public {
        console2.log("Adversary cannot register name belonging to User");
        vm.prank(adversary);
        vm.expectRevert(bytes("Already registered!"));
        simpleNameRegister.register(name);
    }
    // 2nd iteration is an adversary name that is fuzzy rule generated
    function testAdversaryCannotRegisterName(string some_string) public {
        console2.log("Adversary cannot register name belonging to User");
        // vm.prank(adversary);
        vm.prank(some_string);
    }

    function testAdversaryCannotReleaseName() public {
        console2.log("Adversary cannot release name belonging to User");
        vm.prank(adversary);
        vm.expectRevert(bytes("Not your name!"));
        simpleNameRegister.release(name);   
    }

    function testUserCannotRegisterOwnedName() public {
        console2.log("User cannot register a name that he already holds");
        vm.prank(user);
        vm.expectRevert(bytes("Already registered!"));
        simpleNameRegister.register(name);
    }

    function testUserRelease() public {
        console2.log("User releases name that he holds");
        vm.prank(user);
        simpleNameRegister.release(name);
        bool success = (address(0) == simpleNameRegister.holder(name));
        assertTrue(success);
    }
}
