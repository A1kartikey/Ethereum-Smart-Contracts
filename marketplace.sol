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

   event Bid( uint256 NFTid , string   from, uint256 amount);


    constructor (address tokenAddress, address NFTAddress)  {
        token = ERC20(tokenAddress);
        NFT = ERC721(NFTAddress);
        
    }
     address public contractaddress= address(this);

    function listNFTforsale(uint256 _tokenId) external {
        require(msg.sender == NFT.ownerOf(_tokenId),"Only owners can change this status");
       // require(!NFT._exists(_tokenId),"token dose not exist"); // checking with URI if listed NFT is a valid or not
        NFTMap[_tokenId].NFTforSell = true;
        NFTMap[_tokenId].ownerOfNFT = msg.sender;
        NFTMap[_tokenId].bidingStatus =  true ;
        NFTMap[_tokenId].NFTid = _tokenId ;
        NFTMap[_tokenId].NFTheigestBid = 0 ;
    }
    
    function bidding(uint _tokenId , uint256 _bid, string memory _name) external {
        require(NFTMap[_tokenId].bidingStatus == true,"NFT is not allowed not for bid !");
        require(NFT.ownerOf(_tokenId) != msg.sender,"sorry, Owner can not bid !") ;
        require(_bid > 0 , "bid should be greater than 0") ;
        require(_bid <= token.balanceOf(msg.sender),"bidder balance is less than bid"); //check balance before bid 
        // to be check bidding should be allowed by allowence peple
       if ( _bid > NFTMap[_tokenId].NFTheigestBid) {
           NFTMap[_tokenId].NFTheigestBid = _bid ;
           NFTMap[_tokenId].NFTHeigestBidder = msg.sender ;
       }  

       emit Bid (_tokenId , _name , _bid) ;

    }

    function stopBid(uint256 _tokenId ) external {
        require(msg.sender == NFTMap[_tokenId].ownerOfNFT,"only owner can stop the bidding " ); //only owner can stop bidding. 
        NFTMap[_tokenId].bidingStatus =  false ;
    }

    function getHeigestBid(uint256 _tokenId) view public returns (address,uint256,bool) {
            return ( NFTMap[_tokenId].NFTHeigestBidder ,
                     NFTMap[_tokenId].NFTheigestBid,
                     NFTMap[_tokenId].bidingStatus );
    }
   
    function nftBuy(uint256 _tokenId) public {   // NFT should be sold by current owner
        require(NFTMap[_tokenId].NFTforSell,"Token must be on sale first");
        require(NFTMap[_tokenId].bidingStatus != true,"bidding not finished yet");
        require(NFT.ownerOf(_tokenId) == msg.sender,"only owner can allow sell !") ;

        address nftowner=NFTMap[_tokenId].ownerOfNFT; // require msg.sender is winner
        uint nftPrice = NFTMap[_tokenId].NFTheigestBid;
        require(token.allowance(NFTMap[_tokenId].NFTHeigestBidder, address(this)) >= nftPrice, "Insufficient allowance.");
        require(token.balanceOf(NFTMap[_tokenId].NFTHeigestBidder) >= nftPrice, "Insufficient balance.");
        
        NFTMap[_tokenId].NFTforSell = true;

        token.transferFrom(NFTMap[_tokenId].NFTHeigestBidder, NFT.ownerOf(_tokenId), nftPrice);
        NFT.transferFrom(msg.sender, NFTMap[_tokenId].NFTHeigestBidder, _tokenId);

    }
}
