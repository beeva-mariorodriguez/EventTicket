pragma solidity ^0.4.18;
contract EventTicket {
    mapping(bytes32 => bool) public claimedTickets;
    uint16 public availableTickets;
    uint16 public totalSupply;
    string public name;
    constructor(uint16 initialSupply, string ticketName) public {
        totalSupply = initialSupply;
        name = ticketName;
        availableTickets = totalSupply;
    }
    function claimTicket(bytes32 eh) public returns(bytes32) {
        require(claimedTickets[eh] == false);
        require(availableTickets > 0);
        availableTickets--;
        if(availableTickets == 0){
            emit NoMoreTickets();
        }
        claimedTickets[eh] = true;
        emit TicketClaimed(eh);
        return eh;
    }
    function checkTicket(bytes32 eh) public view returns (bool) {
        return claimedTickets[eh];
    }
    function freeTicket(bytes32 eh) public returns (bytes32) {
        require(claimedTickets[eh] == true);
        claimedTickets[eh] = false;
        emit TicketFreed(eh);
        availableTickets++;
        claimedTickets[eh] = false;
        return eh;
    }
    function getHash(string email) public pure returns (bytes32) {
        bytes32 eh = sha256(email);
        return eh;
    }

    event TicketClaimed(bytes32 eh);
    event TicketFreed(bytes32 eh);
    event NoMoreTickets();
}
