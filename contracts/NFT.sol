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

    event Mint(
        address _owner,
        uint256 _tokenId,
        uint256 _priceAmount,
        string _metadataCid
    );
    event Bought(address _to, address _from, uint256 _tokenId);
    event Sale(address _from, address _to, uint256 _tokenId, bytes _data);

    function _baseURI() internal view virtual override returns (string memory) {
        return baseTokenURI;
    }

    function setBaseTokenURI(string memory _baseTokenURI) public {
        baseTokenURI = _baseTokenURI;
    }

    function mint(
        address _to,
        uint256 _priceAmount,
        string memory _metadataCid
    ) public payable returns (uint256) {
        currentTokenId.increment();
        uint256 newItemId = currentTokenId.current();
        _safeMint(_to, newItemId);
        emit Mint(msg.sender, newItemId, _priceAmount, _metadataCid);

        return newItemId;
    }

    // function buy(_saleId, uint256 _tokenId, address _to, address _from) {

    // emit Bought();
    // }
    // function sell(address _from, address _to, uint256 _tokenId, string memory _metadataCid) public payable  {

    // safeTransferFrom(_from, _to, _tokenId);

    // emit Sale(_from, _to, _tokenId, _metadataCid);

    // }
    function sell(
        address _from,
        address _to,
        uint256 _tokenId,
        bytes memory _data
    ) public payable {
        safeTransferFrom(_from, _to, _tokenId);

        emit Sale(_from, _to, _tokenId, _data);
    }
}
