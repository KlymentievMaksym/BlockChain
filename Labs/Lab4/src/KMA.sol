// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";


contract KMA is ERC721, AccessControl
{
    constructor() ERC721("Klymentiev Maksym Andriyovych", "KMA")
    {
        
    }
}