// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract NFTMarketPlace {
    
    ERC20 token;
    ERC721  NFT;
  
    //keep the record for tokenID is listed on sale or not
    mapping(uint256 => bool) public tokenIdForSale;

    mapping(uint256 => uint256) public tokenprice;
    
    
    
  



    mapping(uint256 => address) private nftonwer;
    
    
    constructor (address tokenAddress, address NFTAddress)  {
        token = ERC20(tokenAddress);
        NFT = ERC721(NFTAddress);
       
    
    }
     address public contractaddress= address(this);

    function nftSale(uint256 _tokenId,uint256 _tokenprice, bool forSale) external {
        require(msg.sender == NFT.ownerOf(_tokenId),"Only owners can change this status");
        tokenIdForSale[_tokenId] = forSale;
        tokenprice[_tokenId] = _tokenprice;
        nftonwer[_tokenId] = msg.sender;
        
    }
    
   
    function nftBuy(uint256 _tokenId) public {
        require(tokenIdForSale[_tokenId],"Token must be on sale first");

        address nftowner=nftonwer[_tokenId];
        uint nftPrice = tokenprice[_tokenId];
        require(token.allowance(msg.sender, address(this)) >= nftPrice, "Insufficient allowance.");
        require(token.balanceOf(msg.sender) >= nftPrice, "Insufficient balance.");
        
        token.transferFrom(msg.sender, NFT.ownerOf(_tokenId), nftPrice);
        NFT.transferFrom(nftowner, msg.sender, _tokenId);

    }
}