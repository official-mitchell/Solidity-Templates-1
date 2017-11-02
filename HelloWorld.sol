// bytecode is what is compiled and deployed.
// Deploy here: https://remix.ethereum.org/#version=soljson-v0.4.17+commit.bdeb9e52.js
// From: https://www.youtube.com/watch?v=8jI1TuEaTro&t=118s


pragma solidity 4.0
contract HelloWorld {
  
  // uint - integer is a number that is positive or negative; unsigned uint can only be positive
  // declaring a new variable called "balance". We're shifting the values that the variable "balance" can take
  
  // OPTION 1
  
  uint balance;
  
  // OR YOU COULD DO
  
  // OPTION 2
  
  uint public balance;
  
  // by setting it to "public" this does ______ . IDK what it does
  
  
  // thing from Java
  
  function HelloWorld() {
 
  // every operation costs gas to run.
  // We've now set the variable "balance" to have the value of 1000. We're now setting the value of a state variable
    balance = 1000;
    
  //On remix, if you press create... you can see both transaction cost and execution cost. It generally costs around 20000 to be gas. Setting the "balance" to 1000, and storing data like that, is tremendously more costly... almost 10x more. So we're working with a minimization problem here.
  // you'll be able to see at the left underneath the cost... the address for the particular contract name
  // In browser compiler is great to get started but you're going to need to use Truffle for multiple contracts
  // Linked here: http://truffleframework.com/docs/getting_started/solidity-tests
  
  
    
  }
  
  // You can use test rpc as a testnet for ethereum smart contracts
  // Testrpc is a node js test framework of a blockchain that happens on your computer
  // https://github.com/ethereumjs/testrpc
  

}
