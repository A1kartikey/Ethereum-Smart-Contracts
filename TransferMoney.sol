pragma solidity^0.4.19;

contract TestTransfer{

    struct Detail{
        
        string Name;
        address _owner;
        uint _amount;
    }

    mapping (address => Detail) Details; 


    event Records(address from, address to ,uint amount);

    function TestTransfer() public payable {
        Details[msg.sender]._owner = msg.sender;
        Details[msg.sender]._amount = msg.value ;
        
        
    }
    
    modifier IfOwner(){
        
        require(Details[msg.sender]._owner == msg.sender);
        _;
    }


    function TransferFunds(address _aDdress,string _Name ) IfOwner public payable returns (bool){
        require(msg.value   >=  1 wei );
        require(msg.value <= Details[msg.sender]._amount);
        Details[msg.sender]._amount -= msg.value;
        Details[_aDdress]._amount += msg.value;
        Details[_aDdress].Name = _Name;
        Records(Details[msg.sender]._owner,_aDdress,msg.value);
        return (true);
        
        
    }

    function GetBalance(address _Address) constant public returns (uint,string) {
        
        return (Details[_Address]._amount,Details[_Address].Name);
        
    }
    
    function () public payable  {}      //fallback function
    
    function getbalance()constant public returns (uint) {       //total balance transection in the contract 
        return address(this).balance;
    }
}


