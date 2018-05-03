# EventTicket

simple comtract to manage tickets to internal events

## components used
* (truffle framework)[http://truffleframework.com]
    * deploy the contract
    * run the test ethereum network
* (web3.js)[https://github.com/ethereum/web3.js] Ethereum JavaScript API
* (metamask)[https://metamask.io/] browser addon to interact with the Ethereum network from the browser

## testing the contract
* clone it!
```bash
git clone https://github.com/beeva-mariorodriguez/EventTicket
cd EventTicket
```
* install truffle ``npm install -g truffle``
* launch test ethereum network in a new terminal window
```bash
truffle develop --network=development
```
* run automated tests
```bash
truffle test
```
* deploy the contract to the test network, note the ethereum address assigned to the contract (``0x345ca3e014aaf5dca488057592ee47305d9b3e10``)
```bash
truffle migrate --network=development --reset
...
Running migration: 2_deploy_contracts.js
  Replacing EventTicket...
  ... 0xa70158cc17d7a73104070924cf5e92e630e63188900925c1bf0a15848218bdab
  EventTicket: 0x345ca3e014aaf5dca488057592ee47305d9b3e10
...
```
* interact with the contract using the console
```
truffle(development)> EventTicket.at("0x345ca3e014aaf5dca488057592ee47305d9b3e10").availableTickets()
BigNumber { s: 1, e: 1, c: [ 10 ] }
truffle(development)> EventTicket.at("0x345ca3e014aaf5dca488057592ee47305d9b3e10").claimTicket(1234)
...
truffle(development)> EventTicket.at("0x345ca3e014aaf5dca488057592ee47305d9b3e10").availableTickets()
BigNumber { s: 1, e: 0, c: [ 9 ] }
```

