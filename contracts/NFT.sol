// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFT is ERC721 {
    using Counters for Counters.Counter;

    Counters.Counter private currentTokenId;

    string public baseTokenURI;

    constructor() ERC721("NFT Contract", "NFT") {
        baseTokenURI = "";
    }

    event Mint(address owner, uint256 tokenId, string metadataCid);
    event Sale(address from, address to, uint256 tokenId);
    event Bought(address to, address from, uint256 tokenId);

    function setBaseTokenURI(string memory _baseTokenURI) public {
        baseTokenURI = _baseTokenURI;
    }

    function mint(address to, string memory metadataCid)
        public
        payable
        returns (uint256)
    {
        currentTokenId.increment();
        uint256 newItemId = currentTokenId.current();
        setBaseTokenURI(baseTokenURI);
        _mint(to, newItemId);

        emit Mint(msg.sender, newItemId, metadataCid);

        return newItemId;
    }

    function sell(
        address from,
        address to,
        uint256 tokenId
    ) public payable {
        safeTransferFrom(from, to, tokenId);

        emit Sale(from, msg.sender, tokenId);
    }

    function buy(
        uint256 tokenId,
        address to,
        address from
    ) public payable {
        safeTransferFrom(to, from, tokenId);

        emit Bought(msg.sender, from, tokenId);
    }
}
