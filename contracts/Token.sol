//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    address public admin;

    constructor() ERC20("AirToken", "AT") {
        admin = msg.sender;
        _mint(admin, 100000);
    }

    function mint(address _account, uint256 _amount) external {
        require(msg.sender == admin, "Only admin can mint");
        _mint(_account, _amount);
    }

    function burn(address _account, uint256 _amount) external {
        require(msg.sender == admin, "Only admin can burn");
        _burn(_account, _amount);
    }
}

// 1.minting the token(done)
// 2.transfer the token
// 3.burn the token
// 4.add and remove the address(whitelisting)
