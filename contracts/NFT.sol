// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract NFT is Ownable, ERC721URIStorage, ERC721Burnable {
    using Strings for uint256;

    using Counters for Counters.Counter;
    Counters.Counter private _currentTokenId;

    string public baseTokenURI;
    uint256 private tokenId;
    string public baseExtension;
    uint256 public cost;

    event Mint(address indexed owner, uint256 indexed tokenId, string tokenURI);

    constructor(string memory _name, string memory _symbol)
        ERC721(_name, _symbol)
    {
        "NFT";
        "nft";
        baseTokenURI = "";
    }

    function mint(address recipient, string memory tokenURI_)
        external
        returns (uint256)
    {
        uint256 tokenId = tokenId++;

        _mint(recipient, tokenId);

        _setTokenURI(tokenId, tokenURI_);

        emit Mint(recipient, tokenId, tokenURI_);

        return tokenId;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return ERC721URIStorage.tokenURI(tokenId);
    }

    function _burn(uint256 _tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        ERC721URIStorage._burn(_tokenId);
    }
}
