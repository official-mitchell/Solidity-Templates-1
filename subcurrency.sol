pragma solidity ^0.4.0;

contract Coin {

    // The keyword "public" makes the following variable readable from outside.
    address public minter;
    mapping (address => uint) public balances;

    // Events allow light clients to react on changes efficiently.
    event Sent(address from, address to, uint amount);

    // This is the constructor whose code is run only when the contract is created.
    // QUESTION: what does message sender mean? What is the point of message sending, and what does it mean?
    function Coin() {
        minter = msg.sender;
    }
 
    // If the message sender is not the minter, then return the balances to the receiver whatever the amount sent is
    function mint(address receiver, uint amount) {
        if (msg.sender != minter) return;
        balances[receiver] += amount;
    }

    function send(address receiver, uint amount) {
        if (balances[msg.sender] < amount) return;
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        Sent(msg.sender, receiver, amount);
    }
} 
