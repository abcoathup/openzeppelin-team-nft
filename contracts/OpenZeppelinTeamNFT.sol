// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract OpenZeppelinTeamNFT is ERC721, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant SET_BASEURI_ROLE = keccak256("SET_BASEURI_ROLE");
    string private _baseURIString;

    constructor(string memory baseURIString) ERC721("OpenZeppelin Team NFT", "OZT") {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(MINTER_ROLE, msg.sender);
        _setupRole(SET_BASEURI_ROLE, msg.sender);

        _baseURIString = baseURIString;
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseURIString;
    }

    function safeMint(address to, uint256 tokenId) public {
        require(hasRole(MINTER_ROLE, msg.sender));
        _safeMint(to, tokenId);
    }
    
    function setBaseURI(string memory baseURIString) public {
        require(hasRole(SET_BASEURI_ROLE, msg.sender));
        _baseURIString = baseURIString;
    }
}
