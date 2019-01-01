pragma solidity ^0.4.19; //pragma solidity is a keyword to specify the compiler version.Unlike //c,here we include header files with compiler version

contract studentDetails{ //contract is a keyword to initiate the contract, followed by contract name.

	struct student {	// structure is a user defined data type. it starts with "struct" can contains different other data types.
   	 
    	string sname;
    	string degree;
    	uint year;
    	uint roll;
    	address accountaddress;
   	 
	}

	address owner;  	// creating a variable called "owner".
    
	mapping (address => student) students ;
                	//mapping is a user defined data type.
    
	address[] public studentAccts;
            	//creating a dynamic array to store a students accounts dynamically.

    
	modifier ifOwner() { //modifier is a set of instructions which is executed before the functions  
    	require (owner == msg.sender); //require is a keyword which is similar to "if else"
        	_;
    	}

        	//function to add students.There are 5 inputs passed into to the function,within the brackets .  
    
	function insertDetails(address _address,string _sname,string _degree,uint _year,uint _roll)  public{
	    
    	students[_address].accountaddress = msg.sender; //msg.sender is current address.students address is added using msg.sender
    	students[_address].sname = _sname;         	//add name; "_sname" gets value from placeholder
    	students[_address].degree = _degree;      	//add degree; "_degree" gets value from placeholder
    	students[_address].year = _year;          	//add year; "_year" gets value from placeholder
    	students[_address].roll = _roll;         	//add roll; "_roll" gets value from placeholder
   	 
    	studentAccts.push(_address) +1;         	// increment the count of students address by 1

	}

	function updatedetails(address _address,string _sname, string _degree, uint _year, uint _roll )  public{
                	//function to update the list, of students
   	 
     	students[_address].sname = _sname;
     	students[_address].degree = _degree;
     	students[_address].year = _year;
     	students[_address].roll = _roll;
	}
    
	// function to get students details. the details will be displayed with respect to the unique address of students.
	// we are passing one input to the function(address datatype).the function is returning 4 outputs.
    
 function getStudentDetails(address _address) constant public returns(string,string,uint,uint){

    	return (students[_address].sname,students[_address].degree,

    	students[_address].year,students[_address].roll);

	}
    
    
	// function to get all avaliable students addrerss.
  function getstudentss() view public returns(address[]) {
    	return studentAccts;
	}
    
	//function to students count
	function countstudentss() view public returns (uint) {
    	return studentAccts.length;
	}
    
    
    	//function to validate the entered adress is avaliable in the list  (to check details are correct or not)

	function validateStudent(address valAddress) constant returns(bool){
    	if ((students[valAddress].accountaddress==valAddress)){
        	return true;
    	}
    	else {
        	return false;
    	}
	}
}
