pragma solidity^0.5.1;

contract peertopeerlending{
    
    struct lender{
        uint lbalance;
        string name;
        uint interest;
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
    
    
    function EnrollLender(string memory _name,uint _interest,address _laddress,uint _amount)public{
        lenders[_laddress].Address=_laddress;
        lenders[_laddress].name =_name;
        lenders[_laddress].interest=_interest;
        lenders[_laddress].lbalance =_amount;
        lenderacts.push(_laddress);
    }
    
    function EnrollBorrower(string memory _name,address  _baddress,uint _balance)public{
        borrowers[_baddress]. Address=_baddress;
        borrowers[_baddress].name=_name;
        borrowers[_baddress].bbalance=_balance;
        borroweracts.push(_baddress);
        
    }
    
    function GetLenderDetails(address _address) view public returns(string memory,address,uint,uint){
        return (lenders[_address].name,lenders[_address].Address,lenders[_address].interest,lenders[_address].lbalance);
    }
    
    function GetBorrowers(address _address)view public returns(string memory,address,uint,uint){
        return(borrowers[_address].name,borrowers[_address].Address,borrowers[_address].bbalance,borrowers[_address].repay);
    }
    
    function Loan(address _laddress,address _baddress, uint _amount,uint _time)public{
        require((lenders[_laddress].lbalance > _amount) && (_laddress != _baddress));
        calculation = (lenders[_laddress].interest*_amount*_time)/100;
        lenders[_laddress].lbalance -= _amount ;
        borrowers[_baddress].bbalance += _amount;
        borrowers[_baddress].repay = calculation +_amount;
        
    }
    
    function Repay(address _laddress,address _baddress)  public {
     borrowers[_baddress].bbalance -= borrowers[_baddress].repay;
     lenders[_laddress].lbalance += borrowers[_baddress].repay;
    }
    
    function GetAllBorrowers() public view returns(address[] memory ){
        return borroweracts;
    }
    
    function GetAllLenders() public view returns(address[] memory ){
        return  lenderacts;
    }

    
}
