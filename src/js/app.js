App = {
  web3Provider: null,
  contracts: {},

  init: function() {

    return App.initWeb3();
  },

  initWeb3: function() {

    // Is there an injected web3 instance?
    if (typeof web3 !== 'undefined') {
      App.web3Provider = web3.currentProvider;
    } else {
      // If no injected web3 instance is detected, fall back to Ganache
      App.web3Provider = new Web3.providers.HttpProvider('http://localhost:9545');
    }
    web3 = new Web3(App.web3Provider);


    return App.initContract();
  },

  initContract: function(){

    $.getJSON('EventTicket.json', function(data) {
      // Get the necessary contract artifact file and instantiate it with truffle-contract
      var EventTicketArtifact = data;
      App.contracts.EventTicket = TruffleContract(EventTicketArtifact);
    
      // Set the provider for our contract
      App.contracts.EventTicket.setProvider(App.web3Provider);
   



    //}
 
      // Use our contract to retrieve and mark the adopted pets
      return ;
    });

    return App.bindEvents();
  },

  bindEvents: function() {
      $(document).on('click', '.btn-claimTicket', App.claimTicket);
    
  },



  claimedTicket: function(event){

      alert("ticket been claimed!");

  },

  soldOut: function(event){

      alert("sold out!");

  },


  claimTicket: function(event){

    alert("button pressed");

    //qué hace esta línea?
    event.preventDefault();

    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        alert(error);
        console.log(error);
      }
    
      var account = accounts[0];

      alert(account);

      App.contracts.EventTicket.deployed().then(function(instance) {
        
        // Execute claimTicket as a transaction by sending account
        return instance.claimTicket(434345, {from: account});
      }).then(function(result) {
        alert("claimed ticket!");
      }).catch(function(err) {
        console.log(err.message);
      });
    });

  

   }


};

$(function() {
  $(window).load(function() {
    App.init();
  });
});
