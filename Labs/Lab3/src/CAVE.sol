// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";

contract CAVE is ERC20, AccessControl
{
    uint256 public constant MAX_TRANSFER = 25 * 10 ** 18;

    constructor() ERC20("CAVE token, created for lab in Institute of Physics and Technology", "CAVE-2026")
    {
        uint256 initialSupply = 10_000 * 10 ** decimals();
        _mint(msg.sender, initialSupply);
    }
}