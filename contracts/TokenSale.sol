//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

import "./Token.sol";

contract TokenSale {
    address public admin;
    Token public token;
    uint256 public tokenPrice = 1000000000000000;
    mapping(address => bool) public allowed;

    constructor(Token _token) {
        token = _token;
        admin = msg.sender;
    }

    function getTokenSupply() public view returns (uint256) {
        return token.totalSupply();
    }

    function buyToken(uint256 _amount) public payable {
        require(token.balanceOf(address(this)) >= _amount, "Not enough tokens");
        require(msg.value == _amount * tokenPrice, "Not enough ether");
        require(allowed[msg.sender]==true, "Not allowed");
        token.transfer(msg.sender, _amount);
    }

   function addToWhitelist(address _account) public {
        require(msg.sender == admin, "Only admin can add to whitelist");
        allowed[_account] = true;
    }

    function removeFromWhitelist(address _account) public {
        require(msg.sender == admin, "Only admin can remove from whitelist");
        allowed[_account] = false;
    }

    function burn(address _account, uint256 _amount) public{
        require(msg.sender == admin, "Only admin can burn");
        token.burn(_account, _amount);
    }
     
     
}
