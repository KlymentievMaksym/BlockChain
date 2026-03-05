// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {ERC721URIStorage, ERC721} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";


contract KMA is ERC721URIStorage, AccessControl
{
    bytes32 public constant OWNER_ROLE = keccak256("OWNER_ROLE");
    bytes32 public constant CREATOR_ROLE = keccak256("CREATOR_ROLE");

    uint256 private _nextTokenId;

    constructor() ERC721("Klymentiev Maksym Andriyovych", "KMA")
    {
        address from = msg.sender;
        _grantRole(DEFAULT_ADMIN_ROLE, from);
        _grantRole(OWNER_ROLE, from);
    }

    function setCreator(address newCreator) public onlyRole(OWNER_ROLE)
    {
        _grantRole(CREATOR_ROLE, newCreator);
    }

    function deleteCreator(address newCreator) public onlyRole(OWNER_ROLE)
    {
        _revokeRole(CREATOR_ROLE, newCreator);
    }

    function createPic(string memory tokenURI) public returns (uint256)
    {
        return createPic(msg.sender, tokenURI);
    }

    function createPic(address to, string memory tokenURI) public returns (uint256)
    {
        address from = msg.sender;
        require(hasRole(OWNER_ROLE, from) || hasRole(CREATOR_ROLE, from), "No permission");

        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);

        return tokenId;
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721URIStorage, AccessControl) returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}