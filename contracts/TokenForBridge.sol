// SPDX-License-Identifier: Unlicense
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.5.0/contracts/token/ERC20/extensions/ERC20Burnable.sol

contract Token is ERC20, ERC20Burnable{
    address private owner;
    
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        owner = msg.sender;
    }

    function mint(address user, uint amount) external {
        require(msg.sender == owner, "You are not an owner");
        _mint(user, amount);
    }
    
    function burn(address user, uint amount) external {
        require(msg.sender == owner, "You are not an owner");
        _burn(user, amount);
    }

}