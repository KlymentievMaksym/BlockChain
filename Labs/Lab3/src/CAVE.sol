// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";


contract CAVE is ERC20, AccessControl
{
    bytes32 public constant OWNER_ROLE = keccak256("OWNER_ROLE");
    bytes32 public constant FAUCET_ROLE = keccak256("FAUCET_ROLE");
    address public CAVE_FAUCET;

    uint256 constant PRECISION = 10 ** 18;
    uint256 public constant MAX_TRANSFER = 25 * PRECISION;

    event Claimed(address indexed user, uint256 amount);
    event Minted(address indexed to, uint256 amount);

    constructor() ERC20("Klymentiev Maksym Andriyovych Token", "CAVE-2026")
    {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(OWNER_ROLE, msg.sender);
    
        uint256 initialSupply = 10_000 * PRECISION;
        _mint(msg.sender, initialSupply);
    }

    function setFaucet(address caveFaucet) public onlyRole(OWNER_ROLE)
    {
        if (CAVE_FAUCET != address(0))
        {
            _revokeRole(FAUCET_ROLE, CAVE_FAUCET);
        }
        _grantRole(FAUCET_ROLE, caveFaucet);
        CAVE_FAUCET = caveFaucet;
    }

    function claim(uint256 value) public onlyRole(OWNER_ROLE)
    {
        _mint(msg.sender, value);
    }

    function mint(address to, uint256 amount) public returns (bool)
    {
        require(hasRole(OWNER_ROLE, msg.sender) || hasRole(FAUCET_ROLE, msg.sender), "No permission");
        require(to != address(0));
    
        _mint(to, amount);
    
        return true;
    }

    function _update(address from, address to, uint256 value) internal virtual override
    {
        if (
            from != address(0) && to != address(0)
            && !hasRole(OWNER_ROLE, from)
        )
        {
            require(value <= MAX_TRANSFER, "Transfer exceeds 25 tokens");
        }

        super._update(from, to, value);
    }
}