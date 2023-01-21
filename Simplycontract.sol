// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * Simple contract to deploy into test networks.
 */

 contract SimpleContract {
    address payable public owner;
    mapping(address => uint) public balances;

    event Deposit(uint _amount, address _from);
    event Withdrawal(uint _amount, address _to);

    constructor(){
        owner = payable(msg.sender);
    }

    function deposit() public payable {
        balances[msg.sender] = balances[msg.sender] + msg.value;
        emit Deposit(msg.value, msg.sender);
    }

    function getBalance(address _address) public view returns(uint _balance) {
        _balance = balances[_address];
    }

    function withdraw(uint _amount) external {
        require(balances[msg.sender] >= _amount, "Too low balance");
        balances[msg.sender] = balances[msg.sender] - _amount;
        payable(msg.sender).transfer(_amount);
        emit Withdrawal(_amount, msg.sender);
    }

    function withdrawAll() external {
        require(balances[msg.sender] > 0, "Too low balance");
        balances[msg.sender] = 0;
        payable(msg.sender).transfer(balances[msg.sender]);
        emit Withdrawal(balances[msg.sender], msg.sender);
    }

    receive() external payable {
        deposit();
    }
 }