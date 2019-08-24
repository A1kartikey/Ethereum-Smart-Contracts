pragma solidity^0.5.1;
contract peertopeerlending{
    struct lender{
        string name;
        uint interest;
        
        uint lbalance;
        address Address;
        
    }
    struct borrower{
        string name;
        
        uint bbalance;
        address Address;
          uint repay;
        
    }
    uint calculation;
  
    mapping(address => lender)lenders;
    mapping(address => borrower)borrowers;
    
    address[] lenderacts;
    address[] borroweracts;
    function enrollement(string memory _name,uint _interest,address _laddress,uint _amount)public{
        lenders[_laddress].Address=_laddress;
        lenders[_laddress].name =_name;
        lenders[_laddress].interest=_interest;
        lenders[_laddress].lbalance =_amount;
        lenderacts.push(_laddress);
    }
    function Enrollement(string memory _name,address  _baddress,uint _balance)public{
        borrowers[_baddress]. Address=_baddress;
        borrowers[_baddress].name=_name;
        borrowers[_baddress].bbalance=_balance;
        borroweracts.push(_baddress);
        
     
    }
    
    function getlenderDetails(address _address) view public returns(uint){
        return (lenders[_address].interest);
    }
    function calculations(address _laddress,address _baddress, uint _amount,uint _time)public{
        calculation = (lenders[_laddress].interest*_amount*_time)/100;
        lenders[_laddress].lbalance -= _amount ;
        borrowers[_baddress].bbalance += _amount;
        borrowers[_baddress].repay =
        calculation +_amount;
        
    }
    function repay(address _laddress,address _baddress)  public {
     borrowers[_baddress].bbalance -= borrowers[_baddress].repay;
     lenders[_laddress].lbalance += borrowers[_baddress].repay;
    } 
    function getrepaydetails( address _address) view public  returns(uint){
        return borrowers[_address].repay;
    
    }
    
    function balances(address _laddress,address _baddress)view public returns(uint,uint){
        return(lenders[_laddress].lbalance,borrowers[_baddress].bbalance);
    }


    
    
}
