pragma solidity ^0.4.0;
contract Ballot {

/// Setting up the contract ///

    struct Voter {
        uint weight;
        bool voted;
        uint8 vote;
        address delegate;
    }
   
/// Setting up a new class called "Voter" with attributes of a number that will be called "weight", a yes or no attached to "voted" /// an action called "vote", and a participant called "delegate". ///
/// The uint keyword is a C# sharp reference that signifies an integral type that stores values according to the size and range. ///
    
    struct Proposal {
        uint voteCount;
    }

    address chairperson;
    mapping(address => Voter) voters;
    Proposal[] proposals;

    /// Create a new ballot with $(_numProposals) different proposals.
    function Ballot(uint8 _numProposals) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;
        proposals.length = _numProposals;
    }

    /// Give $(voter) the right to vote on this ballot.
    /// May only be called by $(chairperson).
    function giveRightToVote(address voter) {
        if (msg.sender != chairperson || voters[voter].voted) return;
        voters[voter].weight = 1;
    }

    /// Delegate your vote to the voter $(to).
    function delegate(address to) {
        Voter storage sender = voters[msg.sender]; // assigns reference
        if (sender.voted) return;
        while (voters[to].delegate != address(0) && voters[to].delegate != msg.sender)
            to = voters[to].delegate;
        if (to == msg.sender) return;
        sender.voted = true;
        sender.delegate = to;
        Voter storage delegateTo = voters[to];
        if (delegateTo.voted)
            proposals[delegateTo.vote].voteCount += sender.weight;
        else
            delegateTo.weight += sender.weight;
    }

    /// Give a single vote to proposal $(proposal).
    function vote(uint8 proposal) {
        Voter storage sender = voters[msg.sender];
        if (sender.voted || proposal >= proposals.length) return;
        sender.voted = true;
        sender.vote = proposal;
        proposals[proposal].voteCount += sender.weight;
    }

    function winningProposal() constant returns (uint8 _winningProposal) {
        uint256 winningVoteCount = 0;
        for (uint8 proposal = 0; proposal < proposals.length; proposal++)
            if (proposals[proposal].voteCount > winningVoteCount) {
                winningVoteCount = proposals[proposal].voteCount;
                winningProposal = proposal;
            }
    }
}
