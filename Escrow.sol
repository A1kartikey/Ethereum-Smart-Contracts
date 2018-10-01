pragma solidity ^0.4.18;

contract Escrow {
  uint balance;
  address public buyer;
  address public seller;
  address private escrow;
  uint private start;
  bool buyerOk;
  bool sellerOk;
  function Escrow(address buyer_address, address seller_address) public {
    // this is the constructor function that runs ONCE upon initialization
    buyer = buyer_address;
    seller = seller_address;
    escrow = msg.sender;
    start = now; //now is an alias for block.timestamp, not really "now"
  }
  
  function accept() public {
    if (msg.sender == buyer){
      buyerOk = true;
    } else if (msg.sender == seller){
      sellerOk = true;
    }
    if (buyerOk && sellerOk){
      payBalance();
    } else if (buyerOk && !sellerOk && now > start + 30 days) {
      // Freeze 30 days before release to buyer. The customer has to remember to call this method after freeze period.
      selfdestruct(buyer);
    }
  }
  
  function payBalance() private {
    // we are sending ourselves (contract creator) a fee
    escrow.transfer(this.balance / 100);
    // send seller the balance
    if (seller.send(this.balance)) {
      balance = 0;
    } else {
      throw;
    }
  }
  
  function deposit() public payable {
    if (msg.sender == buyer) {
      balance += msg.value;
    }
  }

  function getEscrowBalance() public returns (uint) {
  	return this.balance;
  }
  
  function cancel() public {
    if (msg.sender == buyer){
      buyerOk = false;
    } else if (msg.sender == seller){
      sellerOk = false;
    }
    // if both buyer and seller would like to cancel, money is returned to buyer 
    if (!buyerOk && !sellerOk){
      selfdestruct(buyer);
    }
  }
  
  function kill() public constant {
    if (msg.sender == escrow) {
      selfdestruct(buyer);
    }
  }
}


