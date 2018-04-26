var EventTicket = artifacts.require("EventTicket");
module.exports = function(deployer) {
    deployer.deploy(EventTicket, 10, "TCK");
};
