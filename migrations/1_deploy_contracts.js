const CustomizedContract = artifacts.require("MyContract");

module.exports = function (deployer) {
  deployer.deploy(CustomizedContract, "Hello, Truffle!"); 
};