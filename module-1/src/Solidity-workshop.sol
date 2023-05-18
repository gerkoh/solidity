// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract SimpleNameRegister {
    mapping(string => address) public holder;
    
    event Register(address indexed owner, string indexed name);

    event Release(address indexed owner, string indexed name);

    function register(string calldata name) public {
        require(holder[name] == address(0), "Already registered!");
        holder[name] = msg.sender;
        emit Register(msg.sender, name);
    }

    function release(string calldata name) public {
        require(holder[name] == msg.sender, "Not your name!");
        delete holder[name];
        emit Release(msg.sender,name);
    }
}
