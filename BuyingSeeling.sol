pragma solidity^0.4.19;
 
 contract Selling {
     
     
     address owner;
     
     struct Detail{
         address Address;
         uint Amount;
         string ItamName;
         uint quantity;
         
     } 
     
     mapping (address => Detail) Details;
     

    modifier IfOwner{
        require(owner == msg.sender);
        _;
    }

     function Selling (string _ItamName,uint _quantity) payable public{
         owner = msg.sender;
         Details[msg.sender].Address = owner;
         Details[msg.sender].Amount  = msg.value;
         Details[owner].ItamName = _ItamName;
         Details[owner].quantity = _quantity;
        
     }
 
    //modifier IfOwner{
    //    Details[msg.sender]    }

     function SetMyNewValue(uint MyNewPrice )public IfOwner  {
         
         Details[msg.sender].Amount = MyNewPrice;
     }
     
     function GetCurrentOwner() constant public returns (address,uint){
     
     return (Details[owner].Address,Details[owner].Amount);
 }
     
    function TrnsferOwnership (address NewOwner) payable public IfOwner returns (bool){
        require(msg.value >= Details[owner].Amount);
        owner = NewOwner;
        Details[owner].Address = owner;
        Details[owner].Amount = msg.value;
        
    }

     function() payable public {}
     
 }
