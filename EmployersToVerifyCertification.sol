pragma solidity ^0.4.19;
import "browser/Students.sol";//include the same file name

contract Employer{  //contract name

   studentDetails s1 = studentDetails(0x8c6aac465302d9f6262b2907f00c62350cf6fd74);
                                           	 
                                            	//s1 is an instance
                                            	//copy the address of the imported file(students.sol)
                                           	 
	function Employer () {	//empty constructor
	}

	function checkBgc(address vaddress) constant returns (string){
        	if(s1.validateStudent(vaddress)){//"validateStudent" is a function in students.sol
            	return "Valid";
        	}
    
    	return "Invalid";
	}
}
