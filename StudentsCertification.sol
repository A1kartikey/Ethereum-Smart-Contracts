pragma solidity ^0.5.1; //pragma is here to specify the version of compiler we are using

contract studentDetails{ //contract is a keyword to initiate the contract, followed by contract name.

struct student { // structure is a user defined data type. it starts with "struct" and can contains different other data types. 
    	string sname;
    	string degree;
    	uint year;
    	uint roll;
    	address accountaddress;
	}
    address owner;  	// creating a variable called "owner" of type address.

 mapping (address => student) students ; //mapping is a user defined data type.Its a key value pair.

    address[]  studentAccts; //creating a dynamic array to store a students accounts dynamically.
    
    constructor () public {  //constructor is a function which runs only once,at the time of deployment.
        owner = msg.sender;  //And this constructor stores current address to the verialbe "owner". 
    
}
 modifier ifOwner() { //modefire is a set of instructions which is executed before the functions where it is specified   

    	require (owner == msg.sender); //require is a keyword which is similar to "if else".It requires less gas compared to "if".
        	_;
    	}





function insertDetails(address _address,string memory _sname,string memory _degree,uint _year,uint _roll)  public ifOwner {
            //function to add students. Before this function the prgram will check for modifies as mentioned above.
    	students[_address].accountaddress = _address;
    	students[_address].sname = _sname;
    	students[_address].degree = _degree;
    	students[_address].year = _year;
    	students[_address].roll = _roll;
    	studentAccts.push(_address) +1;
	}



	function updatedetails(address _address,string memory _sname, string memory _degree)  public ifOwner{
                	//function to update the list, of students
     	students[_address].sname = _sname;
     	students[_address].degree = _degree;

	}


     function getStudentDetails(address _address) view public returns(string memory,string memory,uint,uint){
         //function to display students with respect to their address.
    
    	return (students[_address].sname,students[_address].degree,
    	students[_address].year,students[_address].roll);
         
     }

    function getstudentss() view public returns(address[] memory) {
        //function to get all students addresses.
    
    	return studentAccts;  
    }
    function countstudentss() view public returns (uint) {
        //function to display number of students enrolled.
    	return studentAccts.length;
    }
	//function to validate the entered details are correct or not
	function validateStudent(address valAddress) view public returns(bool){
    	if ((students[valAddress].accountaddress==valAddress)){
        	return true;
    	}
    	else {
        	return false;
    	}
	}   
}


