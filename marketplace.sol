// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract NFTMarketPlace {
    
    ERC20 token;
    ERC721  NFT;
  
    // keep the record for tokenID is listed on sale or not
  //  mapping(uint256 => bool) public tokenIdForSale;

    mapping(uint256 => uint256) public tokenprice;


    mapping(uint256 => address) private nftonwer;

    struct NFTstruct {
            uint256 NFTid ;
            address ownerOfNFT ;
            uint256 NFTheigestBid ;
            address NFTHeigestBidder ; 
            bool NFTforSell ;
            bool bidingStatus ;
    }

    mapping (uint256 => NFTstruct) NFTMap ;

    constructor (address tokenAddress, address NFTAddress)  {
        token = ERC20(tokenAddress);
        NFT = ERC721(NFTAddress);
        
    }
     address public contractaddress= address(this);

    function nftSale(uint256 _tokenId) external {
        require(msg.sender == NFT.ownerOf(_tokenId),"Only owners can change this status");
        NFTMap[_tokenId].NFTforSell = true;
        NFTMap[_tokenId].ownerOfNFT = msg.sender;
        NFTMap[_tokenId].bidingStatus =  true ;
        NFTMap[_tokenId].NFTid = _tokenId ;
        NFTMap[_tokenId].NFTheigestBid = 0 ;
    }
    
    function bidding(uint _tokenId , uint256 _bid) external {
        require(NFTMap[_tokenId].bidingStatus == true,"NFT is not allowed not for bid !");
        require(NFT.ownerOf(_tokenId) != msg.sender,"sorry, Owner can not bid !") ;
        require(_bid > 0 , "bid less than 0") ;
       
       if ( _bid > NFTMap[_tokenId].NFTheigestBid) {
           NFTMap[_tokenId].NFTheigestBid = _bid ;
           NFTMap[_tokenId].NFTHeigestBidder = msg.sender ;
       }  

    }

    function stopBid(uint256 _tokenId ) external {
        require(); //only owner can stop bidding. 
        NFTMap[_tokenId].bidingStatus =  false ;
    }

    function getHeigestBid(uint256 _tokenId) view public returns (address,uint256) {
            return (NFTMap[_tokenId].NFTHeigestBidder , NFTMap[_tokenId].NFTheigestBid );
    }
   
    function nftBuy(uint256 _tokenId) public {
        require(NFTMap[_tokenId].NFTforSell,"Token must be on sale first");

        address nftowner=NFTMap[_tokenId].ownerOfNFT; // require msg.sender is winner
        uint nftPrice = NFTMap[_tokenId].NFTheigestBid;
        require(token.allowance(msg.sender, address(this)) >= nftPrice, "Insufficient allowance.");
        require(token.balanceOf(msg.sender) >= nftPrice, "Insufficient balance.");
        
        NFTMap[_tokenId].NFTforSell = true;

        token.transferFrom(msg.sender, NFT.ownerOf(_tokenId), nftPrice);
        NFT.transferFrom(nftowner, msg.sender, _tokenId);

    }
}
