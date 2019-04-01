pragma solidity^0.4.21;

contract Idealabs {
    
    string name;
    uint age;
    
    event Event (string fname,uint Age);
    
    function setInstructor(string _name,uint _age) public {
        
        name = _name;
        age = _age;
        
    emit Event (_name,_age);
        
    }

    function getInstructor() view public returns(string,uint){
        
        return (name,age);
    }
    
}